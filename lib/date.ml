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

(* e.g 18 to 6 *)
(* e.g 8 to 8 *)
let twenfourToTwelve s = 
    let x = int_of_string s in
    let y = if x <= 12 then s
    else string_of_int (x-12) in
    removePrefixZero y

(* e.g 18 to PM *)
(* e.g 8 to AM *)
let amORpmStr s = if (int_of_string s) < 12 then "AM" else "PM"

(* e.g 2025-04-01 to 1 April 2025 *)
let dayIsoToName s = 
    let splitted = String.split_on_char '-' s in
    (List.nth splitted 2 |> removePrefixZero) ^ " " ^ (List.nth splitted 1 |> monthName) ^ " " ^ (List.nth splitted 0)

let timeIsoToName s = 
    let splitted = String.split_on_char ':' s in
    (List.nth splitted 0 |> twenfourToTwelve) ^ ":" ^ (List.nth splitted 1) ^ " " ^ (List.nth splitted 0 |> amORpmStr)

(* e.g 2025-04-01 18:00:00 to 1 April 2025  6:00 PM *)
let dateIsoToName s = 
    let dt = String.split_on_char ' ' s in
    (List.nth dt 0 |> dayIsoToName) ^ " - " ^ (List.nth dt 1 |> timeIsoToName)
