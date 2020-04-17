#' Makes and opens a new script with the BitBar template.
#'
#' Also runs the command to make the new script executable by BitBar.
#'
#' @param name Name of your menu. Isn't used by BitBar so mostly irrelevant. No periods.
#' @param refreshRate How often would you like the menu to refresh. Format is 10s, 5m, 1h, etc. Defaults to 1h.
#' @param dir Where to save the script. Defaults to your working directory.
#'
#' @export
#' @examples
#' bb_new("MyMenu")
#' bb_new("MyMenu", "5s", "path/to/my/BitBar/directory")

bb_new <- function(
  name = "myBitBaR",
  refresh.rate = "1h",
  dir = getwd()
){
  name <-
    name %>%
    stringr::str_remove_all("\\.")

  template <- "#!/usr/local/bin/Rscript
# Check that the path above is correct to make this path usable by BitBar:
# In Terminal type 'which Rscript'. If the result is different than the path above, replace.
# e.g. you might change it to #!/usr/bin/Rscript or #!/foo/bar/etc/Rscript

# Optional: BitBar Metadata ----
# Only needed if you want to share your menu item on BitBar's website. Feel free to delete.
# BitBar's website: https://getbitbar.com

# <bitbar.title>TITLE</bitbar.title>
# <bitbar.version>v1.0</bitbar.version>
# <bitbar.author>YOUR NAME</bitbar.author>
# <bitbar.author.github>YOUR GITHUB USERNAME</bitbar.author.github>
# <bitbar.desc>DESCRIPTION</bitbar.desc>
# <bitbar.image>IMAGE URL</bitbar.image>
# <bitbar.dependencies>R</bitbar.dependencies>

# BitBar Initialize ----
options(tidyverse.quiet = TRUE) # This keeps BitBar from printing out the standard Tidyverse conflicts output.
library(tidyverse, warn.conflicts = FALSE, quietly = TRUE)
library(magrittr, warn.conflicts = FALSE, quietly = TRUE)
library(bitbaR)

# BitBar ----

bb_head(\"\U0001f697\") # Loads an icon and Refresh button for your BitBar.

bb_print(\"I am a menu line.\")

bb_print(\"---\") # Makes a section line.
bb_print(\"I am green!\", bb_attributes(color = \"green\"))
# bb_print(\"I am also green! | color=green\") # Same as above

bb_print(\"---\")
bb_print(\"I link to Google.\", bb_attributes(URL = \"https://www.google.com/\"))
# bb_print(\"I am also Google. | href=https://www.google.com/\") # Same as above

bb_print(\"---\")
bb_print(\"Nested submenu using mtcars:\")
mtcars %>%
  rownames_to_column(\"cars\") %>%
  mutate(menu_name = \"mtcars\") %>%
  arrange(cyl, cars) %>%
  bb_nest(menu_name, cyl, cars) %>% # Creates a submenu based on a table's columns.
  bb_print()
"

  BitBarFile <-
    file.path(
      dir
      ,paste0(
        name
        ,"."
        ,refresh.rate
        ,".R"
      )
    )

  if(!file.exists(BitBarFile)){
    file.create(BitBarFile)
    con = file(BitBarFile)

    writeLines(
      con = con,
      text = template)
    close(con)
  }

  executable_command <- paste0("chmod +x '", BitBarFile ,"'")
  system(executable_command)

  file.edit(BitBarFile)
}





