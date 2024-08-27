local M = {}
--
-- -- execute command and clean the resulting string
function Get_cmd_result(cmd)
  local handle = io.popen(cmd)
  if handle == nil then
    return
  end
  local result = handle:read('*a'):gsub('"', ''):gsub('%s+', '')
  handle:close()
  return result
end
--
-- -- get the base commit hash for the active gh pr
function Get_base_ref()
  local base_ref_name = Get_cmd_result 'gh pr view --json baseRefName | jq ".baseRefName"'
  return base_ref_name
end

package.loaded['diffview.ui.models.file_tree.node'] = nil

local oop = require 'diffview.oop'
local original_node_module = require 'diffview.ui.models.file_tree.node'

function Toggle_viewed_state(file_path, viewed)
  local handle_pr = io.popen 'gh pr view --json id | jq ".id"'
  if handle_pr == nil then
    return
  end

  local pr_number = handle_pr:read '*a'
  handle_pr:close()
  pr_number = pr_number:gsub('%s+', '')

  local query
  if viewed then
    query = string.format(
      [[
     mutation {
       unmarkFileAsViewed(input: {path: "%s", pullRequestId: %s}) {
         pullRequest {
           files(first:100){
             nodes {
               path
               viewerViewedState
             }
           }
         }
       }
     }
   ]],
      file_path,
      pr_number
    )
  else
    query = string.format(
      [[
   mutation {
     markFileAsViewed(input: {path: "%s", pullRequestId: %s}) {
       pullRequest {
         files(first:100){
           nodes {
             path
             viewerViewedState
           }
         }
       }
     }
   }
 ]],
      file_path,
      pr_number
    )
  end

  local cmd = string.format('gh api graphql -f query=%s', vim.fn.shellescape(query))

  local handle = io.popen(cmd)
  if handle == nil then
    return
  end
  local result = handle:read '*a'
  handle:close()

  if result == '' then
    print 'Error: GraphQL mutation returned no data.'
    return
  end
end

function Get_Pr_Files()
  -- Get the current checked-out PR number
  local handle_pr = io.popen 'gh pr view --json number --jq ".number"'
  if handle_pr == nil then
    return
  end
  local pr_number = handle_pr:read '*a'
  handle_pr:close()
  pr_number = pr_number:gsub('%s+', '')

  -- Get the owner and repo name
  local handle_owner = io.popen 'gh repo view --json owner | jq -r ".owner.login"'
  if handle_owner == nil then
    return
  end
  local owner = handle_owner:read '*a'
  handle_owner:close()
  owner = owner:gsub('%s+', '')

  local handle_repo = io.popen 'gh repo view --json name | jq -r ".name"'
  if handle_repo == nil then
    return
  end
  local repo = handle_repo:read '*a'
  handle_repo:close()
  repo = repo:gsub('%s+', '')

  if owner == '' or repo == '' then
    print 'Error: Could not fetch the owner or repo name.'
    return
  end

  local query = [[
    query ($owner: String!, $repo: String!, $prNumber: Int!) {
      repository(owner: $owner, name: $repo) {
        pullRequest(number: $prNumber) {
          files(first: 100) {
            nodes {
              path
              viewerViewedState
            }
          }
        }
      }
    }
  ]]

  -- Run the gh command to get the list of files and their viewed state
  local cmd = string.format(
    'gh api graphql -F query=%s -F owner=%s -F repo=%s -F prNumber=%d',
    vim.fn.shellescape(query),
    vim.fn.shellescape(owner),
    vim.fn.shellescape(repo),
    tonumber(pr_number)
  )

  local handle = io.popen(cmd)
  if handle == nil then
    return
  end
  local result = handle:read '*a'
  handle:close()
  if result == '' then
    print 'Error: GraphQL query returned no data.'
    return
  end

  -- Parse the JSON result
  local json = vim.fn.json_decode(result)
  if not json or not json.data or not json.data.repository or not json.data.repository.pullRequest or not json.data.repository.pullRequest.files then
    print 'Error: Unexpected JSON structure.'
    return
  end

  return json.data.repository.pullRequest.files.nodes
end

-- Load the original Node class
local Node = original_node_module.Node

-- Create a custom Node class that extends the original Node class
local CustomNode = oop.create_class('CustomNode', Node)

local CHECKED_ICON = '\u{f05e0}'
local UNCHECKED_ICON = '\u{f0130}'

function Add_label(basename, viewed)
  if viewed then
    return CHECKED_ICON .. ' ' .. basename
  else
    return UNCHECKED_ICON .. ' ' .. basename
  end
end
-- Override the init method
function CustomNode:init(name, data)
  -- Call the original init method
  Node.init(self, name, data)

  if data ~= nil and _G.use_custom_label then
    if data.basename ~= nil and not data.basename:match('^' .. CHECKED_ICON) and not data.basename:match('^' .. UNCHECKED_ICON) then
      for _, file in ipairs(M.file_statuses) do
        if file.path == data.path then
          if file.viewerViewedState == 'VIEWED' then
            data.viewed = true
            data.original_basename = data.basename
            data.basename = Add_label(data.basename, true)
          elseif file.viewerViewedState == 'UNVIEWED' or file.viewerViewedState == 'DISMISSED' then
            data.viewed = false
            data.original_basename = data.basename
            data.basename = Add_label(data.basename, false)
          end
        end
      end
    end
  end
end

-- Replace the original Node class with the custom one
original_node_module.Node = CustomNode
-- Define a global flag
_G.use_custom_label = false

-- Function to set the flag
function _G.set_use_custom_label(value)
  _G.use_custom_label = value
end

function M.Toggle_viewed()
  local lib = require 'diffview.lib'
  local view = lib.get_current_view()
  if view ~= nil then
    local file = view:infer_cur_file()

    Toggle_viewed_state(file.path, file.viewed)
    if file.viewed then
      file.basename = Add_label(file.original_basename, false)
      file.viewed = false
    else
      file.basename = Add_label(file.original_basename, true)
      file.viewed = true
    end
    vim.cmd 'DiffviewRefresh'
  end
end

-- Ensure the module is loaded correctly
package.loaded['diffview.ui.models.file_tree.node'] = original_node_module

vim.api.nvim_exec2(
  [[
  command! -nargs=* DiffviewOpen lua _G.set_use_custom_label(false); require('diffview').open(<f-args>)
]],
  {}
)

function _G.Open_Diffview_PR()
  -- pull origin to get the latest changes
  local base = Get_base_ref()
  local fetch_command = 'G fetch origin ' .. base .. ' -q'
  -- vim.cmd(fetch_command)

  M.file_statuses = Get_Pr_Files()
  _G.set_use_custom_label(true)
  local diffview = require 'diffview'

  -- TODO: replace master with result of gh pr view --json baseRefName
  local base_ref = 'origin/' .. base
  diffview.open { base_ref, 'HEAD' }
end

vim.keymap.set('n', '<leader>hp', _G.Open_Diffview_PR, { desc = 'Preview PR Diff' })

return M
