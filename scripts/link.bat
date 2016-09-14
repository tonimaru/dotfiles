@echo off
setlocal

set current_path=%~dp0
set dotfiles_root_path=%current_path%..\

SET vim_src_path=%dotfiles_root_path%_vim
SET vim_dst_path=%USERPROFILE%\vimfiles

mklink /j %vim_dst_path% %vim_src_path%

endlocal

