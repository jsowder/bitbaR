#' Parses bitbar attributes into a string.
#'
#' See https://github.com/matryer/bitbar#plugin-api for all possible attributes.
#' Partial list: href, color, font, size, length, alternate
#'
#' @param ... Attributes to pass. (e.g. href = "https://www.google.com")
#'
#' @export
#' @examples
#' bb_attributes(href = "https://www.google.com")
#' bb_attributes(font = 2 + 2)
#' bb_attributes(param1 = 14, param2 = "cake")

bb_attributes <- function(
  ...
){
  ok_params <- paste(
    sep = "|"
    ,"^href$"            # href=.. to make the item clickable
    ,"^color$"           # color=.. to change their text color. eg. color=red or color=#ff0000
    ,"^font$"            # font=.. to change their text font. eg. font=UbuntuMono-Bold
    ,"^size$"            # size=.. to change their text size. eg. size=12
    ,"^bash$"            # bash=.. to make the item run a given script terminal with your script e.g. bash=/Users/user/BitBar_Plugins/scripts/nginx.restart.sh if there are spaces in the file path you will need quotes e.g. bash="/Users/user/BitBar Plugins/scripts/nginx.restart.sh"
    ,"^param[:digit:]*$" # param1= to specify arguments to the script. additional params like this param2=foo param3=bar full example bash="/Users/user/BitBar_Plugins/scripts/nginx.restart.sh" param1=--verbose assuming that nginx.restart.sh is executable or bash=/usr/bin/ruby param1=/Users/user/rubyscript.rb param2=arg1 param3=arg2 if script is not executable
    ,"^terminal$"        # terminal=.. start bash script without opening Terminal. true or false
    ,"^refresh$"         # refresh=.. to make the item refresh the plugin it belongs to. If the item runs a script, refresh is performed after the script finishes. eg. refresh=true
    ,"^dropdown$"        # dropdown=.. May be set to true or false. If false, the line will only appear and cycle in the status bar but not in the dropdown
    ,"^length$"          # length=.. to truncate the line to the specified number of characters. A … will be added to any truncated strings, as well as a tooltip displaying the full string. eg. length=10
    ,"^trim$"            # trim=.. whether to trim leading/trailing whitespace from the title. true or false (defaults to true)
    ,"^alternate$"       # alternate=true to mark a line as an alternate to the previous one for when the Option key is pressed in the dropdown
    ,"^templateImage$"   # templateImage=.. set an image for this item. The image data must be passed as base64 encoded string and should consist of only black and clear pixels. The alpha channel in the image can be used to adjust the opacity of black content, however. This is the recommended way to set an image for the statusbar. Use a 144 DPI resolution to support Retina displays. The imageformat can be any of the formats supported by Mac OS X
    ,"^image$"           # image=.. set an image for this item. The image data must be passed as base64 encoded string. Use a 144 DPI resolution to support Retina displays. The imageformat can be any of the formats supported by Mac OS X
    ,"^emojize$"         # emojize=false will disable parsing of github style :mushroom: into 🍄
    ,"^ansi$"            # ansi=false turns off parsing of ANSI codes.
  )

  features <-
    rlang::dots_list(...
                     , .ignore_empty = "all"
                     , .homonyms = "keep") %>%
    lapply(tibble::enframe) %>%
    lapply(dplyr::mutate_all, as.character) %>%
    dplyr::bind_rows(.id = "call") %>%
    dplyr::mutate(
      bb_ready = dplyr::case_when(
        call == "URL" ~ stringr::str_glue("href={value}")
        , call %>% stringr::str_detect(ok_params) ~ stringr::str_glue("{call}={value}")
        , TRUE ~ "Error"
      )
    ) %>%
    dplyr::filter(bb_ready != "Error") %>%
    .$bb_ready %>%
    paste(., collapse = " ") %>%
    paste0(" | ", .)

  return(
    features
  )
}
