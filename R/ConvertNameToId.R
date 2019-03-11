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
    id_match <- id_to_name[gene_name, ID]
    if(length(id_match) > 1) {
        warning(paste0("Multiple matches found for ", gene_name))
        warning(print(id_match))
        return(NA)
    }
    if(!is.na(id_match) & dim(id_match)[[1]] == 1) {
        return(id_match)
    }
    alias_match <- id_to_alias[alias == gene_name]
    if(dim(alias_match)[[1]] == 1) {
        return(alias_match[, ID])
    }
    warning(paste0("No match found for ", gene_name))
    return(NA)
}
