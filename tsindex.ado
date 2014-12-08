program tsindex

version 12.1
	
syntax varname(numeric), base(integer) newvar(string)

local 1 = subinstr("`1'",",","",.)

qui {
	
	xtset
	tempvar tag
	gen `tag' = 1 if `r(timevar)'==`base'

	if "`r(panelvar)'"=="" {
		sort `tag'
		gen `newvar' = 100*`1'/`1'[1] if `tag'[1]==1
	}
	else {
		bys `r(panelvar)' (`tag'): gen `newvar' = 100*`1'/`1'[1] if `tag'[1]==1
	}
	
	sort `r(panelvar)' `r(timevar)'

}
	
end
