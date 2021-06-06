scriptencoding utf-8

" vim-repo-edit
" Author: Sheldon Johnson
" Version: 0.3

if exists('g:loaded_repo_edit') || &compatible
  finish
endif

let g:loaded_repo_edit = 1

function! RepoEdit(url, branch = '') abort
	let l:branch = ''
	if len(a:branch) != 0
	  let l:branch = ' --branch=' . a:branch
	endif

	let l:basename = system("echo -n (" . "basename " . a:url . " .git" . ")")

	let l:parent = system("dirname " . a:url)
	let l:parent_name = system("echo -n (" . "basename " . l:parent . ")")

	let l:repo_path = fnamemodify(tempname(),':h') . "/" . "repo-edit" . "/" .  l:parent_name  .  "/" . l:basename

	execute "!git clone --depth=1" . l:branch . ' ' . a:url . " " . l:repo_path

	execute "lcd ". l:repo_path
	edit .
endfunction

command! -nargs=+ RepoEdit call RepoEdit(<f-args>)
