#' ConvertNameToId
#'
#' Convert non-systematic gene names to FlyBase IDs.
#'
#' @param gene_name Single non-systematic gene name
#'
#' @return Returns a single FlyBase gene identifier, or warns if no match was
#'   found.
#'
#' @export
#'
#' @import data.table
#'


ConvertNameToId <- function(gene_name) {
    if(length(gene_name) != 1) {
        stop(
            paste('ConvertNameToId expects a single non-systematic gene name.',
                  '  If you\'re using data.table, try with `by=`',
                  '  or check for duplicate rows.',
                  sep = '\n'))
    }
    
    # exact ID matches
    id_match <- id_to_name[gene_name, ID]
    if(!is.na(id_match) && length(id_match) == 1) {
        return(id_match)
    }
    if(length(id_match) > 1) {
        warning(paste0("Multiple ID matches found for ", gene_name))
        warning(paste(id_match, collapse = ", "))
        return(as.character(NA))
    }
    
    # Alias matches
    alias_match <- id_to_alias[alias == gene_name, ID]
    if(!is.na(alias_match) && length(alias_match) == 1) {
        return(alias_match)
    }
    if(length(alias_match) > 1) {
        warning(paste0("Multiple alias matches found for ", gene_name))
        warning(paste(alias_match, collapse = ", "))
        return(as.character(NA))
    }

    # no matches
    warning(paste0("No match found for ", gene_name))
    return(as.character(NA))
}
