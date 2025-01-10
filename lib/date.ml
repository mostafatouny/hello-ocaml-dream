let monthName x = match x with
    | "01" -> "January"
    | "02" -> "February"
    | "03" -> "March"
    | "04" -> "April"
    | "05" -> "May"
    | "06" -> "June"
    | "07" -> "July"
    | "08" -> "August"
    | "09" -> "September"
    | "10" -> "October"
    | "11" -> "November"
    | "12" -> "December"
    | _ -> "unknown"

(* e.g 04 to 4 *)
let removePrefixZero s = if s |> String.starts_with ~prefix:"0" then String.sub s 1 1 else s

(* e.g 2025-04-01 to 1 April 2025 *)
let dateIsoToName s = 
    let splitted = String.split_on_char '-' s in
    (List.nth splitted 2 |> removePrefixZero) ^ " " ^ (List.nth splitted 1 |> monthName) ^ " " ^ (List.nth splitted 0)
