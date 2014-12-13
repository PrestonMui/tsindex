program tsindex

version 12.1
		
syntax varlist, Timebase(integer) [Indexto(real 100)] [Prefix(string)] [Suffix(string)]

qui {
	
	xtset
	local pvar = "`r(panelvar)'"
	local tvar = "`r(timevar)'"

	foreach var of local varlist {

		if "`prefix'"=="" & "`suffix'"=="" local suffix "_index"

		local newvar = "`prefix'" + "`var'" + "`suffix'"

		tempvar temp

		if "`pvar'"=="" {
			egen `temp' = total(cond(`tvar'==`timebase',`var',.))
		}

		else {
			by `pvar': egen `temp' = total(cond(`tvar'==`timebase',`var',.))
		}
		gen `newvar' = `indexto' * `var' / `temp'
	}

	sort `pvar' `tvar'
}

end
