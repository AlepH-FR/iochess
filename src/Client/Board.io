Client_Board := Object clone do(

    matrix := list(
        list("r", "n", "b", "k", "q", "b", "n", "r"),
        list("p", "p", "p", "p", "p", "p", "p", "p"),
        list(" "," "," "," "," "," "," "," "),
        list(" "," "," "," "," "," "," "," "),
        list(" "," "," "," "," "," "," "," "),
        list(" "," "," "," "," "," "," "," "),
        list("P", "P", "P", "P", "P", "P", "P", "P"),
        list("R", "N", "B", "K", "Q", "B", "N", "R")
    )

    lettersToSymbol := Object clone do(
        k := "♔"
        q := "♕"
        r := "♖"
        b := "♗"
        n := "♘"
        p := "♙"
        K := "♚"
        Q := "♛"
        R := "♜"
        B := "♝"
        N := "♞"
        P := "♟"

        translate := method(
            letter,

            if(letter == " ",
                return " ",
                return self getSlot(letter) asUTF8
            )
        )
    )
    
    columns := list("A", "B", "C", "D", "E", "F", "G", "H")
    
    cWhite := "\\033[5;30;47m"
    cBlack := "\\033[1;5;30m"
    cReset := "\\033[0m"

    draw := method( 
       System system("clear")
        
        line := "echo \"\n    A  B  C  D  E  F  G  H  \"";
        System system(line)
        
        color := cWhite
        matrix foreach(key, value,
          
            line := "echo \" " .. key + 1 .. " "
            color := if(color == cBlack, cWhite, cBlack)

            value foreach(key, value,
                color := if(color == cBlack, cWhite, cBlack)
                line := line .. color .. " " .. lettersToSymbol translate(value) .. " " .. cReset
            )

            line := line .. cReset "\"" 
            System system(line)
        )

        "\nYour action ?\n> " println; 
        action := File standardInput readLine
        process(action)
    )

    columnLetterToPosition := method(
        letter,

        columns foreach(key, value,   
            if(value == letter, return key)
        )
    )

    process := method(
        action,

        if(action size != 4, 
            draw()
            return
        )
        
        pos_col := columnLetterToPosition(action at(0) asCharacter)
        pos_row := doString(action at(1) asCharacter .. " - 1")
        mov_col := columnLetterToPosition(action at(2) asCharacter)
        mov_row := doString(action at(3) asCharacter .. " - 1")

        piece := matrix at(pos_row) at (pos_col)
        matrix at(pos_row) atPut(pos_col, " ")
        matrix at(mov_row) atPut(mov_col, piece)

        draw()
    )
)
