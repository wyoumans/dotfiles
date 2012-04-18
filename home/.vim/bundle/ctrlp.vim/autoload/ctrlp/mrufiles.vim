" =============================================================================
" File:          autoload/ctrlp/mrufiles.vim
" Description:   Most Recently Used Files extension
" Author:        Kien Nguyen <github.com/kien>
" =============================================================================

" Static variables {{{1
fu! ctrlp#mrufiles#opts()
	let opts = {
		\ 'g:ctrlp_mruf_max': ['s:max', 250],
		\ 'g:ctrlp_mruf_include': ['s:in', ''],
		\ 'g:ctrlp_mruf_exclude': ['s:ex', ''],
		\ 'g:ctrlp_mruf_case_sensitive': ['s:csen', 1],
		\ 'g:ctrlp_mruf_relative': ['s:re', 0],
		\ 'g:ctrlp_mruf_last_entered': ['s:mre', 0],
		\ }
	for [ke, va] in items(opts)
		exe 'let' va[0] '=' string(exists(ke) ? eval(ke) : va[1])
	endfo
	let s:csen = s:csen ? '#' : '?'
endf
cal ctrlp#mrufiles#opts()
fu! ctrlp#mrufiles#list(bufnr, ...) "{{{1
	if s:locked | retu | en
	let bufnr = a:bufnr + 0
	if bufnr > 0
		let fn = fnamemodify(bufname(bufnr), ':p')
		let fn = exists('+ssl') ? tr(fn, '/', '\') : fn
		if empty(fn) || !empty(&bt) || ( !empty(s:in) && fn !~# s:in )
			\ || ( !empty(s:ex) && fn =~# s:ex ) || !filereadable(fn)
			retu
		en
	en
	if !exists('s:cadir') || !exists('s:cafile')
		let s:cadir = ctrlp#utils#cachedir().ctrlp#utils#lash().'mru'
		let s:cafile = s:cadir.ctrlp#utils#lash().'cache.txt'
	en
	if a:0 && a:1 == 2
		let mrufs = []
		if a:0 == 2
			let mrufs = ctrlp#utils#readfile(s:cafile)
			cal filter(mrufs, 'index(a:2, v:val) < 0')
		en
		cal ctrlp#utils#writecache(mrufs, s:cadir, s:cafile)
		retu map(mrufs, 'fnamemodify(v:val, '':.'')')
	en
	" Get the list
	let mrufs = ctrlp#utils#readfile(s:cafile)
	" Remove non-existent files
	if a:0 && a:1 == 1
		cal filter(mrufs, '!empty(ctrlp#utils#glob(v:val, 1)) && !s:excl(v:val)')
		if exists('+ssl')
			cal map(mrufs, 'tr(v:val, ''/'', ''\'')')
			cal filter(mrufs, 'count(mrufs, v:val) == 1')
		en
		cal ctrlp#utils#writecache(mrufs, s:cadir, s:cafile)
	en
	" Return the list with the active buffer removed
	if bufnr == -1
		let crf = fnamemodify(bufname(winbufnr(winnr('#'))), ':p')
		let crf = exists('+ssl') ? tr(crf, '/', '\') : crf
		let mrufs = empty(crf) ? mrufs : filter(mrufs, 'v:val !='.s:csen.' crf')
		if s:re
			let cwd = exists('+ssl') ? tr(getcwd(), '/', '\') : getcwd()
			cal filter(mrufs, '!stridx(v:val, cwd)')
		en
		retu map(mrufs, 'fnamemodify(v:val, '':.'')')
	en
	" Remove old entry
	cal filter(mrufs, 'v:val !='.s:csen.' fn')
	" Insert new one
	cal insert(mrufs, fn)
	" Remove oldest entry or entries
	if len(mrufs) > s:max | cal remove(mrufs, s:max, -1) | en
	cal ctrlp#utils#writecache(mrufs, s:cadir, s:cafile)
endf "}}}
fu! s:excl(fn) "{{{
	retu !empty(s:ex) && a:fn =~# s:ex
endf "}}}
fu! ctrlp#mrufiles#init() "{{{1
	let s:locked = 0
	aug CtrlPMRUF
		au!
		au BufReadPost,BufNewFile,BufWritePost *
			\ cal ctrlp#mrufiles#list(expand('<abuf>', 1))
		if s:mre
			au BufEnter,BufUnload *
				\ cal ctrlp#mrufiles#list(expand('<abuf>', 1))
		en
		au QuickFixCmdPre  *vimgrep* let s:locked = 1
		au QuickFixCmdPost *vimgrep* let s:locked = 0
	aug END
endf
"}}}

" vim:fen:fdm=marker:fmr={{{,}}}:fdl=0:fdc=1:ts=2:sw=2:sts=2
