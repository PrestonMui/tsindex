program tsindex

version 12.1
	
syntax varname(numeric), base(integer) newvar(string)

local 1 = subinstr("`1'",",","",.)

qui {
	tempvar temp
	
	xtset
	local pvar = "`r(panelvar)'"
	local tvar = "`r(timevar)'"

	if "`pvar'"=="" {
		egen `temp' = total(cond(`tvar'==`base',`1',.))
	}

	else {
		by `pvar': egen `temp' = total(cond(`tvar'==`base',`1',.))
	}

	gen `newvar' = 100 * `1' / `temp'

	sort `pvar' `tvar'
}

end
