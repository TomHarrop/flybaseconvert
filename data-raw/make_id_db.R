#!/usr/bin/env Rscript

library(rtracklayer)
library(GenomicRanges)
library(data.table)

gff <- import.gff("data/dmel-all-r6.26.gff",
                  format = "gff3",
                  feature.type = "gene")

id_to_name <- as.data.table(mcols(gff))[, .(ID, Name, fullname, Alias)]
setkey(id_to_name, Name)

id_to_alias <- id_to_name[, .(alias = unlist(Alias)), by = ID]
setkey(id_to_alias, alias)

# save data
usethis::use_data(id_to_name,
                  id_to_alias,
                  internal = TRUE, 
                  overwrite = TRUE) 
