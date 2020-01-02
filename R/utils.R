#' Returns a CAT outline of the class, based on the Rmd's titles
#' @param files The full path of all of the Rmd files
#' @export
bdc_utils_outline <- function(files = bdc_list_rmds()) {
  all_tocs <- lapply(files, toc)
  all_tocs <- paste0(all_tocs, collapse = "") 
  cat(all_tocs)
}
#' Returns a vector with a list of libraries used in the workbook
#' @param files The full path of all of the Rmd files
#' @export
bdc_utils_libraries <- function(files = bdc_list_rmds()) {
  lib_list <- lapply(files, get_libraries)
  lib_list <- Reduce(c, lib_list)
  unique(lib_list)
}

#' Returns a vector with the path to each workbook
#' @param book_path The path to the workbook files
#' @export
bdc_list_rmds <- function(book_path = "workbook") {
  book_dir <- dir(book_path)
  book_files <- book_dir[grepl("Rmd", book_dir)]
  book_files <- book_files[book_files != "index.Rmd"]
  file.path(book_path, book_files)
}

#' Copies the workbooks into another folder and re-numbers the steps
#' @param book_path The path to the workbook files
#' @param exercise_folder The folder address to save the new files to
#' @export
bdc_utils_exercises <- function(book_path = "workbook", exercise_folder = "") {
  book_dir <- dir(book_path)
  book_files <- book_dir[grepl("Rmd", book_dir)]
  book_files <- book_files[book_files != "index.Rmd"]
  book_files <- file.path(book_path, book_files)
  lapply(
    book_files,
    copy_renumbered,
    exercise_folder
  )
}

copy_renumbered <- function(src_path, target_folder) {
  workbook <- readLines(src_path)
  has_title <- as.logical(lapply(workbook, function(x) substr(x, 1, 1) == "#"))
  title_pos <-  which(has_title)
  title_pos <- c(1, title_pos, length(workbook))
  for(j in 2:length(title_pos)) {
    from <- title_pos[j - 1]
    to <- title_pos[j]
    section <- workbook[from:to]
    is_numbered <- as.logical(lapply(section, function(x) substr(x, 1, 2) == "1."))
    locations <- from + which(is_numbered) - 1
    lapply(
      seq_along(locations),
      function(x) {
        l <- workbook[locations[x]]
        l <- substr(l, 4, nchar(l))
        l <- paste0(x, ". ", l)
        workbook[locations[x]] <<- l
      }
    )
  }
  writeLines(
    workbook,
    if(target_folder == "") {
      basename(src_path)
    } else {
      file.path(
        target_folder, 
        basename(src_path)
      )
    }
  )
}

toc <- function(file_path) {
  re <- readLines(file_path)
  has_title <- as.logical(lapply(re, function(x) substr(x, 1, 1) == "#"))
  only_titles <- re[has_title]
  titles <- trimws(gsub("#", "", only_titles))
  links <- trimws(gsub("`", "", titles))
  links <- tolower(links)
  links <- trimws(gsub(" ", "-", links))
  links <- trimws(gsub(",", "", links))
  toc_list <- lapply(
    seq_along(titles),
    function(x) {
      pad <- ifelse(substr(only_titles[x], 1, 2) == "##", "    - ", "  - ")
      paste0(pad, titles[x])
    }
  )
  paste0(paste(toc_list, collapse = "\n"), "\n")
}

get_libraries <- function(file_path) {
  re <- readLines(file_path)
  has_library <- grepl("library\\(", re)
  only_libs <- re[has_library]
  libs <- gsub("library\\(", "", only_libs)
  libs <- gsub("\\)", "", libs)
  libs <- trimws(libs)
  unique(libs)
}

install_command <- function() {
  all_libs <- paste0("\"", library_list(), "\"", collapse = ", ")
  cat(paste0("install.packages(c(", all_libs, "))"))
}

pkg_workbook_files <- function(book_path = system.file("workbook", package = "bigdataclass")
) {
  book_dir <- dir(book_path)
  book_files <- book_dir[grepl("Rmd", book_dir)]
  book_files <- book_files[book_files != "index.Rmd"]
  file.path(book_path, book_files)
}
