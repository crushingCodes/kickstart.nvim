function Get_base_ref()
  local handle_pr = io.popen 'gh pr view --json baseRefName | jq ".baseRefName"'
  if handle_pr == nil then
    return
  end

  local base_ref = handle_pr:read('*a'):gsub('"', ''):gsub('%s+', '') -- Remove quotes and extra whitespace or newline characters
  handle_pr:close()
  local cmd = 'git merge-base HEAD ' .. base_ref
  local handle = io.popen(cmd)
  if handle == nil then
    return
  end

  local merge_base = handle:read('*a'):gsub('%s+', '') -- Remove any extra whitespace or newline characters

  handle:close()
  return merge_base
end

local M = {}

package.loaded['diffview.ui.models.file_tree.node'] = nil

local oop = require 'diffview.oop'
local original_node_module = require 'diffview.ui.models.file_tree.node'

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
-- Override the init method
function CustomNode:init(name, data)
  -- Call the original init method
  Node.init(self, name, data)

  if data ~= nil and _G.use_custom_label then
    if data.basename ~= nil and not data.basename:match('^' .. CHECKED_ICON) and not data.basename:match('^' .. UNCHECKED_ICON) then
      for _, file in ipairs(M.file_statuses) do
        if file.path == data.path then
          if file.viewerViewedState == 'VIEWED' then
            data.basename = CHECKED_ICON .. ' ' .. data.basename
          elseif file.viewerViewedState == 'UNVIEWED' or file.viewerViewedState == 'DISMISSED' then
            data.basename = UNCHECKED_ICON .. ' ' .. data.basename
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

-- Ensure the module is loaded correctly
package.loaded['diffview.ui.models.file_tree.node'] = original_node_module
vim.api.nvim_exec2(
  [[
  command! -nargs=* DiffviewOpenWithLabel lua _G.set_use_custom_label(true); require('diffview').open(<f-args>)
]],
  {}
)

vim.api.nvim_exec2(
  [[
  command! -nargs=* DiffviewOpen lua _G.set_use_custom_label(false); require('diffview').open(<f-args>)
]],
  {}
)

function Open_Diffview_PR()
  vim.cmd 'G pull -q'

  local base = Get_base_ref()
  M.file_statuses = Get_Pr_Files()
  _G.set_use_custom_label(true)
  local diffview = require 'diffview'
  diffview.open { base }
end

vim.keymap.set('n', '<leader>hp', Open_Diffview_PR, { desc = 'Preview PR Diff' })
return M
