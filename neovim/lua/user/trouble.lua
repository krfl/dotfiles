local status_ok, trouble = pcall(require, "trouble")
if not status_ok then
  return
end

trouble.setup {
    auto_open = true, -- automatically open the list when you have diagnostics
    auto_close = true, -- automatically close the list when you have no diagnostics
    use_diagnostic_signs = true -- enabling this will use the signs defined in your lsp client
}