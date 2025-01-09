let show_int = [%show: int]
let show_string_list : string list -> string = [%show: string list]

let show_user_list : (int * string * string * string * int * int option * int option) list -> string = [%show: (int * string * string * string * int * int option * int option) list]
let show_event_list : (int * string * string * string) list -> string = [%show: (int * string * string * string) list]
