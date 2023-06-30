IDEAL 
MODEL small
STACK 100h
DATASEG

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; V A R I A B L E S ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;------------------------------------------------------------------------------------------------------------------;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    Board db '8','2','7','1','5','4','3','9','6'
          db '9','6','5','3','2','7','1','4','8'
          db '3','4','1','6','8','9','7','5','2'
          db '5','9','3','4','6','8','2','7','1'
          db '4','7','2','5','1','3','6','8','9' 
          db '6','1','8','9','7','2','4','3','5'
          db '7','8','6','2','3','5','9','1','4'
          db '1','5','4','7','9','6','8','2','3'
          db '2','3','9','8','4','1','5','6','7' ;Holds all numbers of the solved sudoku board (the array of the board)

    Blockcatcher db 3 dup(1), 3 dup(2),3 dup(3)
                 db 3 dup(1), 3 dup(2),3 dup(3)
                 db 3 dup(1), 3 dup(2),3 dup(3)
                 db 3 dup(4), 3 dup(5),3 dup(6)
                 db 3 dup(4), 3 dup(5),3 dup(6)
                 db 3 dup(4), 3 dup(5),3 dup(6)
                 db 3 dup(7), 3 dup(8),3 dup(9)
                 db 3 dup(7), 3 dup(8),3 dup(9)
                 db 3 dup(7), 3 dup(8),3 dup(9) ;The array of the sudoku board's blocks (each number represents the number of the block)

    ;start of board 1190, end of board is 2504, space between one square horizontly is 160 and vertically is 4

    constantnumbers db 81 dup(0) ;The array of constant numbers locations

    CurrentSquare dw  1190 ;Holds the current location of the player on the screen

    Currentnum db '_' ;This variable holds the number the player recently inputted on the sudoku board

    Currentloc db 0 ;This variable holds the players current location within the board array 

    dir db ? ;This variable holds the digit pressed on the keyboard
    
    Mistakes db '0','1','2','3' ;This variable holds the digits printed on the location of the digit '0' in the mistakes text on screen, to show the player how many mistakes has he made

    Numbers db '1','2','3','4','5','6','7','8','9','$' ;This array is used in winsearch procedure in which the game makes sure, that the player did'nt win and solve incorrectly

    Mistakescount db 0 ;This variable counts the number of mistakes the player has made

    Youlost db 0  ;The variable checks if the player has lost(1) or not(0)

    Youwon db 0 ;This variable checks if the player has won(1) or not(0)

    countnums db 0 ;This variable counts the number of numbers erased during the boardcreate procedure

    constantcaught db 0 ;This variable checks if the location the player is moving from, erasing or placing a number on is a constant number(1) or not(0)

    Inputsignarray db 'I','n','p','u','t' ;This array holds the letters of the word "Input" that is on the screen

    Nochange db 0 ;This variable checks whether or not a different number is inputed by the player 

    BoardClone db '8','2','7','1','5','4','3','9','6'
               db '9','6','5','3','2','7','1','4','8'
               db '3','4','1','6','8','9','7','5','2'
               db '5','9','3','4','6','8','2','7','1'
               db '4','7','2','5','1','3','6','8','9' 
               db '6','1','8','9','7','2','4','3','5'
               db '7','8','6','2','3','5','9','1','4'
               db '1','5','4','7','9','6','8','2','3'
               db '2','3','9','8','4','1','5','6','7' ;This array holds the copy all numbers of the solved sudoku board 


Openingscreen db '                                                                             ',13,10  ;This variable is the opening screen of the game
             db '================================================================================',13,10
             db '                                                                               ',13,10
             db '                                                                               ',13,10
             db '                                                                               ',13,10
             db '                                                                               ',13,10
             db '            //\\   ||    || |\\\         //\\     ||   // ||    ||             ',13,10
             db '           //  \\  ||    || || \\       //  \\    ||  //  ||    ||             ',13,10
             db '          //       ||    || ||  \\     //    \\   || //   ||    ||             ',13,10
             db '          \\       ||    || ||   \\   //      \\  ||//    ||    ||             ',13,10
             db '           \\      ||    || ||    \\ //        \\ |//     ||    ||             ',13,10
             db '            \\\\   ||    || ||    // \\        // |\\     ||    ||             ',13,10
             db '               \\  ||    || ||   //   \\      //  ||\\    ||    ||             ',13,10
             db '                \\ ||    || ||  //     \\    //   || \\   ||    ||             ',13,10
             db '            \\  //  \\  //  || //       \\  //    ||  \\   \\  //              ',13,10 
             db '             \\//    \\//   |///         \\//     ||   \\   \\//               ',13,10 
             db '                                                                               ',13,10
             db '                            Press any space to continue                        ',13,10
             db '                                                                               ',13,10
             db '                                                                               ',13,10
             db '                                                                               ',13,10
             db '                                                                               ',13,10
             db '================================================================================',13,10
             db '                                                                              $',13,10  
    
Lobby         db '                                                                              ',13,10  ;This variable is the lobby screen
             db '================================================================================',13,10
             db '                                     Lobby:                                    ',13,10
             db '--------------------------------------------------------------------------------',13,10
             db '                                  C- Controls                                  ',13,10
             db '                                                                               ',13,10
             db '                                 E- Game rules                                 ',13,10
             db '                                                                               ',13,10
             db '                           ESC- Return to opening screen                       ',13,10 
             db '          |=============================================================|      ',13,10 
             db '          |        ////           //\\ ||||||    /\      |\\  ||||||    |      ',13,10
             db '          |       //             //      ||     //\\     ||\\   ||      |      ',13,10
             db '          |      //        ||||  \\\\    ||    //  \\    ||//   ||      |      ',13,10
             db '          |      \\  /////          \\   ||   ////\\\\   ||\\   ||      |      ',13,10
             db '          |       \\  //          \\ \\  ||  //      \\  || \\  ||      |      ',13,10
             db '          |        \\//            \\//  || //        \\ ||  \\ ||      |      ',13,10
             db '          |=============================================================|      ',13,10 
             db '                             Made by Yuval Rosenthal                           ',13,10
             db '================================================================================',13,10 
             db '                                                                               ',13,10
             db '                                                                              $',13,10

Controls      db '                                                                              ',13,10  ;This variable is the screen that shows the controls the player
             db '================================================================================',13,10 ;Uses to move, quit, place and erase numbers
             db '                                     Keyboard                                  ',13,10
             db '--------------------------------------------------------------------------------',13,10
             db '         1-9- Numbers that you can input(press on the keyboard to input)       ',13,10
             db '                                                                               ',13,10
             db '                              O- Erase the number                              ',13,10
             db '                                                                               ',13,10
             db '                           Q- Input selection procedure                        ',13,10
             db '                                                                               ',13,10
             db '                                   W- Move up                                  ',13,10
             db '                                                                               ',13,10
             db '                                  A- Move left                                 ',13,10 
             db '                                                                               ',13,10 
             db '                                  S- Move down                                 ',13,10
             db '                                                                               ',13,10
             db '                                  D- Move right                                ',13,10
             db '                                                                               ',13,10
             db '                             Esc- Quit(NOT RECOMMENDED)                        ',13,10
             db '================================================================================',13,10
             db '                                                                               ',13,10
             db '                                                                              $',13,10

Gamerules     db '                                                                              ',13,10   ;This variable is the screen that shows the rules of the game
             db '================================================================================',13,10
             db '                               Game rules and Info                             ',13,10
             db '--------------------------------------------------------------------------------',13,10
             db '     Sudoku is a game, that involves filling a board with all numbers from 1-9.',13,10
             db '     The Board is constructed out of 81 squares there are only 4 rules:        ',13,10
             db '                                                                               ',13,10
             db '     1. Each number can only appear once in each line, column and block.       ',13,10
             db '                                                                               ',13,10
             db '     2. If you will not do 1.(if you make a mistake), 3 times you will lose.   ',13,10
             db '                                                                               ',13,10
             db '     3. If you fill the sudoku board with all numbers from 1-9, YOU WIN!       ',13,10 
             db '                                                                               ',13,10 
             db '     4. DO NOT DISAPPOINT SHMULIK!                                             ',13,10
             db '                                                                               ',13,10
             db '     Block- A 3x3 square on the sudoku board(there are 9 of those in total).   ',13,10
             db '================================================================================',13,10
             db '                                                                               ',13,10
             db '                                                                               ',13,10
             db '                                                                              $',13,10

Intermission1     db '                                                                              ',13,10 ;This variable is the 1st screen that appears when the player starts
             db '================================================================================',13,10     ;the game
             db '                                                                               ',13,10
             db '                                                                               ',13,10
             db '                                                                               ',13,10
             db '                                                                               ',13,10
             db '                                                                               ',13,10
             db '                                                                               ',13,10
             db '  ||\\    //\\   ||//\\  //\\||   //\\   ||//\\  //\\|| ||        //\\   ||//\\',13,10
             db '  || \\  //  \\  |//  \\//  \\|  //  \\  |//  \\//  \\| ||       //  \\  |/    ',13,10
             db '  ||/// ////\\\\ ||    ||    || ////\\\\ ||    ||    || ||//\\  ////\\\\ ||    ',13,10
             db '  ||\\  \\       ||          || \\       ||          || |||  || \\       ||    ',13,10
             db '  || \\  \\\///  ||          ||  \\\///  ||          || ||\\//   \\\///  ||    ',13,10 
             db '                                                                               ',13,10 
             db '                                                                               ',13,10
             db '                                                                               ',13,10
             db '                                                                               ',13,10
             db '                                                                               ',13,10
             db '                                                                               ',13,10
             db '================================================================================',13,10
             db '                                                                               ',13,10
             db '                                                                              $',13,10

Intermission2     db '                                                                             ',13,10 ;This variable is the 2nd screen that appears when the player starts
             db '================================================================================',13,10    ;the game
             db ' ||\\ |||| ////     ||\\ ||\\  //\\ |||||| ||  || |||||| ||\\                  ',13,10
             db ' ||//  || //        ||// ||// //  \\  ||   ||__|| ||____ ||//                  ',13,10
             db ' ||\\  || \\ ////   ||\\ ||\\ \\  //  ||   ||""|| ||"""" ||\\                  ',13,10
             db ' ||// |||| \\//     ||// || \\ \\//   ||   ||  || |||||| || \\                 ',13,10
             db '                                                                               ',13,10
             db '  //\\ ||    || |\      /| ||  || ||   |||||| || //    ||||||  //\\            ',13,10
             db ' //    ||    || |\\    //| ||  || ||     ||   ||//       ||   //               ',13,10
             db ' \\\\  |||||||| ||\\  //|| ||  || ||     ||   |||        ||   \\\\\            ',13,10
             db '   //  ||    || || \\// || ||  || ||     ||   ||\\       ||      //            ',13,10
             db '\\//   ||    || ||  \/  ||  \\//  |||| |||||| || \\    |||||| \\//             ',13,10
             db '                                                                               ',13,10 
             db ' \\            // //\\  |||||| //// ||  || |||||| |\  ||  ////   ||            ',13,10 
             db '  \\    /\    // //  \\   ||  //    ||__||   ||   ||\ || //      ||            ',13,10
             db '   \\  //\\  // ////\\\\  ||  \\    ||""||   ||   ||\\|| \\ ////               ',13,10
             db '    \\//  \\// //      \\ ||   \\\\ ||  || |||||| || \\|  \\//   ||            ',13,10
             db '================================================================================',13,10
             db '                                                                               ',13,10
             db '                                                                               ',13,10
             db '                                                                               ',13,10
             db '                                                                              $',13,10

Boardlength  db '                                                          ',13,10 ;This variable is the board screen, basicly the game screen
             db '                                   _________________      ',13,10
             db '                Mistakes: 0/3     |_|_|_|_|_|_|_|_|_|     ',13,10
             db '                                  |_|_|_|_|_|_|_|_|_|     ',13,10
             db '                Input             |_|_|_|_|_|_|_|_|_|     ',13,10
             db '                                  |_|_|_|_|_|_|_|_|_|     ',13,10
             db '                                  |_|_|_|_|_|_|_|_|_|     ',13,10
             db '                                  |_|_|_|_|_|_|_|_|_|     ',13,10
             db '                                  |_|_|_|_|_|_|_|_|_|     ',13,10
             db '                                  |_|_|_|_|_|_|_|_|_|     ',13,10
             db '                                  |_|_|_|_|_|_|_|_|_|     ',13,10
             db '                                  """""""""""""""""""     ',13,10
             db '                                                          ',13,10
             db '                                                          ',13,10
             db '                                                          ',13,10
             db '                                                          ',13,10
             db '                                                          ',13,10
             db '                                                          ',13,10
             db '                                                          ',13,10
             db '                                                         $',13,10   

Victory db '                                                                             ',13,10 ;This variable is the 1st screen that appears when the players wins
      db '================================================================================',13,10
      db '     ////    |\\    ||||      /\    ||||||      ||   //\\   ||\\               ',13,10
      db '    //       ||\\   ||       //\\     ||        ||  //  \\  ||//               ',13,10
      db '   //        |///   ||||    //  \\    ||        || //    \\ ||\\               ',13,10
      db '   \\   //// ||\\   ||     ////\\\\   ||        || \\    // || \\              ',13,10
      db '    \\  //   || \\  ||    //      \\  ||    \\  ||  \\  //  || //              ',13,10
      db '     \\//    ||  \\ |||| //        \\ ||     \\//    \\//   ||//               ',13,10
      db '                                                                               ',13,10
      db '     ////  //\\   |\      //| |\\         /\      ||\\   |||| ||               ',13,10
      db '    //    //  \\  ||\    //|| ||\\       //\\     || \\  ||   ||               ',13,10
      db '   //    //    \\ ||\\  // || |///      //  \\    ||  \\ |||| ||               ',13,10
      db '   \\    \\    // || \\//  || ||\\     ////\\\\   ||  // ||   ||               ',13,10
      db '    \\    \\  //  ||  \/   || || \\   //      \\  || //  ||                    ',13,10
      db '     \\\\  \\//   ||       || ||  \\ //        \\ ||//   |||| ||               ',13,10
      db '                                                                               ',13,10
      db '                                                                               ',13,10
      db '                                                                               ',13,10
      db '                                                                               ',13,10
      db '                                                                               ',13,10
      db '                                                                               ',13,10
      db '                                                                               ',13,10
      db '================================================================================',13,10
      db '                                                                              $',13,10

Victory2 db '                                                                             ',13,10 ;This variable is the 2nd screen that appears when the players wins 
      db '================================================================================',13,10
      db '   ||\\ |||||| ////       ||\\  |\\    //\\ |||||| ||  || ||||| |\\            ',13,10
      db '   ||//   ||  //          ||//  ||\\  //  \\  ||   ||  || ||    ||\\           ',13,10
      db '   ||\\   || //           ||\\  |/// //    \\ ||   |||||| ||||| |///           ',13,10
      db '   || \\  || \\   ////    || \\ ||\\ \\    // ||   ||  || ||    ||\\           ',13,10
      db '   || //  ||  \\  //      || // || \\ \\  //  ||   ||  || ||    || \\          ',13,10
      db '   ||// |||||| \\//       ||//  ||  \\ \\//   ||   ||  || ||||| ||  \\         ',13,10
      db '                                                                               ',13,10
      db '   \\                // |||||| ||   ||        ||\\  ||||                       ',13,10
      db '    \\              //    ||   ||   ||        ||//  ||                         ',13,10
      db '     \\    //\\    //     ||   ||   ||        ||\\  ||||                       ',13,10
      db '      \\  //  \\  //      ||   ||   ||        || || ||                         ',13,10
      db '       \\//    \\//     |||||| |||| ||||      ||//  ||||                       ',13,10
      db '                                                                               ',13,10
      db '   ||\\ |\\    //\\   ||    || ||\\   ||                                       ',13,10
      db '   ||// ||\\  //  \\  ||    || || \\  ||                                       ',13,10
      db '   ||   |/// //    \\ ||    || ||  \\ ||                                       ',13,10
      db '   ||   ||\\ \\    // ||    || ||  // ||                                       ',13,10
      db '   ||   || \\ \\  //   \\  //  || //                                           ',13,10
      db '   ||   ||  \\ \\//     \\//   ||//   ||                                       ',13,10
      db '                                                                               ',13,10
      db '================================================================================',13,10
      db '                                                                              $',13,10

Lose   db '                                                                            ',13,10 ;This variable is the 1st screen that appears when the players loses 
      db '================================================================================',13,10
      db '                                                                               ',13,10
      db '   \\    // //\\   ||    ||    ||  ||      /\ \\        // ||||                ',13,10
      db '    \\  // //  \\  ||    ||    ||  ||     //\\ \\      //  ||                  ',13,10
      db '     \||/ //    \\ ||    ||    ||||||    //  \\ \\    //   ||||                ',13,10
      db '      ||  \\    // ||    ||    ||  ||   ////\\\\ \\  //    ||                  ',13,10
      db '      ||   \\  //   \\  //     ||  ||  //      \\ \\//     ||                  ',13,10
      db '      ||    \\//     \\//      ||  || //        \\ \/      ||||                ',13,10
      db '                                                                               ',13,10
      db '       /\      |\   ||   ////    ||\\   |||| ||\\     ||\\ |||||| ////         ',13,10
      db '      //\\     ||\  ||  //       ||//   ||   || \\    ||//   ||  //            ',13,10
      db '     //  \\    ||\\ || //        |\\    |||| ||  \\   ||\\   || //             ',13,10
      db '    ////\\\\   || \\|| \\  ///// ||\\   ||   ||  //   || \\  || \\  /////      ',13,10
      db '   //      \\  ||  \\|  \\  //   || \\  ||   || //    || //  ||  \\  //        ',13,10
      db '  //        \\ ||   \|   \\//    ||  \\ |||| ||//     ||// |||||| \\//         ',13,10
      db '                                                                               ',13,10
      db '    ||\\ ||\\  //\\ |||||| ||  || |||| ||\\  ||                                ',13,10
      db '    ||// ||// //  \\  ||   |||||| ||__ ||//  ||                                ',13,10
      db '    ||\\ ||\\ \\  //  ||   ||  || ||"" ||\\                                    ',13,10
      db '    ||// || \\ \\//   ||   ||  || |||| || \\ ||                                ',13,10
      db '                                                                               ',13,10
      db '================================================================================',13,10
      db '                                                                              $',13,10

Lose2  db '                                                                            ',13,10 ;This variable is the 2nd screen that appears when the players loses 
      db '===============================================================================',13,10
      db '                                                                               ',13,10
      db '    \\    // //\\   ||  ||    ||  ||      /\ \\        // ||||                 ',13,10
      db '     \\  // //  \\  ||  ||    ||  ||     //\\ \\      //  ||                   ',13,10
      db '      \||/ //    \\ ||  ||    ||||||    //  \\ \\    //   ||||                 ',13,10
      db '       ||  \\    // ||  ||    ||  ||   ////\\\\ \\  //    ||                   ',13,10
      db '       ||   \\  //  ||  ||    ||  ||  //      \\ \\//     ||                   ',13,10
      db '       ||    \\//    \\//     ||  || //        \\ \/      ||||                 ',13,10
      db '                                                                               ',13,10
      db '    ||\\  |||| |||| |\   ||    //\\   |||| |\   || ||||||                      ',13,10
      db '    ||//  ||   ||   ||\  ||    \\     ||   ||\  ||   ||                        ',13,10
      db '    ||\\  |||| |||| ||\\ ||     \\\\  |||| ||\\ ||   ||                        ',13,10
      db '    || \\ ||   ||   || \\||        \\ ||   || \\||   ||                        ',13,10
      db '    || // ||   ||   ||  \\|        // ||   ||  \\|   ||                        ',13,10
      db '    ||//  |||| |||| ||   \|     \\//  |||| ||   \|   ||                        ',13,10
      db '                                                                               ',13,10
      db '    |||| || //\\   |||| \\            // ||  || |||| ||\\   ||||               ',13,10
      db '    ||   || \\     ||    \\    /\    //  ||  || ||   ||//   ||                 ',13,10
      db '    |||| ||  \\\\  ||||   \\  //\\  //   |||||| |||| ||\\   ||||               ',13,10
      db '    ||   ||     \\ ||      \\//  \\//    ||  || ||   || \\  ||                 ',13,10
      db '    |||| |||| \\// ||||     \/    \/     ||  || |||| ||  \\ ||||               ',13,10
      db '===============================================================================',13,10
      db '                                                                              $',13,10

Lose3 db '                                                                               ',13,10 ;This variable is the 3rd screen that appears when the players loses 
    db '                                                                                 ',13,10
    db '                                                                                 ',13,10
    db '                                                                                 ',13,10
    db '                                                                                 ',13,10
    db '                                                                                 ',13,10
    db '                                                                                 ',13,10
    db '                                                                                 ',13,10
    db '                                                                                 ',13,10
    db '                                                                                 ',13,10
    db '                                                                                 ',13,10
    db '                                                                                 ',13,10
    db '                                                                                 ',13,10
    db '                                                                                 ',13,10
    db '                                                                                 ',13,10
    db '                                                                                 ',13,10
    db '                                                                                 ',13,10
    db '                                                                                 ',13,10
    db '                                                                                 ',13,10
    db '                                                                                 ',13,10
    db '                                                                                 ',13,10
    db '                                                                                 ',13,10
    db '                                                                                 ',13,10
    db '                                                                                $',13,10
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; C O N S T A N T S;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;------------------------------------------------------------------------------------------------------------------;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

    Red equ 4d ; The color red

    Grey equ 7d ;The color grey

    Orange equ 6d ;The color orange, used to define constant numbers onboard(those are unremovable and are meant to to help the player solve the sudoku)

    Blue equ 9d ;The color blue, used to color the location the player is currently on

    Black equ 0000d ;The color black

    Rowspace equ 160d ; Range from one row to the next

    Startingsquare equ 1190d ;The location of the first cell of the Sudoku board in the board array

    Lastsquare equ 80d ;The location of the last cell of the Sudoku board in the board array

    LastLoc equ 2504d ;The last location of the Sudoku board on the screen

    Mistakesloc equ 1172d ;Location of the mistakes counter on the screen

    Inputsignloc equ 1472d ;Location of the input sign on the screen

CODESEG
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; P R O C E D U R E S ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;------------------------------------------------------------------------------------------------------------------;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    proc blackscreen 
				;This procedure prints a black screen
				;ax recieves the color black(0), cx the size the of cells on the screen(25*80*2=4000d) and bx is used to move from one cell to another on the screen
                ;Input: None
                ;Output: A black screen
		push ax
		push bx
		push cx
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
		mov cx,25*80*2
		xor ax,ax
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
		clean:
			mov [es:bx], ax
			add bx, 2
			loop clean
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
		pop cx
		pop bx
		pop ax
		ret 
	endp blackscreen
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	proc delay 
				;This procdure outputs a slower process of the codes running speed
		push cx 
		mov cx, 150
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
		outerloop:
			push cx 
			mov cx, 0ffffh 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
			innerloop:
				dec cx 
				cmp cx, 0 
				jne innerloop
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
			pop cx  
			dec cx 
			cmp cx, 0
			jne outerloop 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
		pop cx 
		ret 
	endp delay
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    proc boarddraw
            ;This procedure prints the Sudoku board screen(the game screen)

            ;Input: Offset of boardlength [bp+4]

            ;Output: The game screen
        push bp
        mov bp,sp
        push dx
        push ax
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;    
        mov dx,[bp+4] ;Offset of boardlength
        mov ah,09h
        int 21h
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
        pop ax
        pop dx
        pop bp
        ret 2
    endp boarddraw
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    proc opening
            ;This procedure calls procedures that restart the game, print the lobby screen, print the pregame screens and start the game

            ;Input: The offset of variables Openingscreen [bp+4], Lobby [bp+6], dir [bp+8], Controls [bp+10], GameRules [bp+12], Intermissionscreen1 [bp+14],
                    ;Intermissionscreen2 [bp+16], Boardlength [bp+18], Currentloc [bp+22], Countnums [bp+24], Currentsquare [bp+28], Currentnum [bp+30], Youlost [bp+34],
                    ;Mistakescount [bp+36] and Youwon [bp+38]. 
                    ;In addition to the offset of arrays Board [bp+20], constantnumbers [bp+26] and BoardClone [bp+32]

            ;Output: The opening screen
        push bp
        mov bp,sp
        push dx
        push ax
        push bx
        push di
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;    
        push [bp+38] ;offset Youwon
        push [bp+36] ;offset Mistakescount
        push [bp+34] ;offset Youlost
        push [bp+26] ;offset constantnumbers
        push [bp+32] ;offset Boardclone
        push [bp+20] ;offset Board
        call restartgame
    loadstart:
        mov dx,[bp+4] ;offset openingscreen
        mov ah,09h
        int 21h
    screen:
        xor ax,ax
	    mov ah,0						;If there is no input, move 0 into ah, and interrupt 16h in order to wait for a key to be pressed on the keyboared,
	    int 16h	
        cmp al, 32d
        jne screen
        
        push [bp+12] ;offset Gamerules
        push [bp+10] ;offset Controls
        push [bp+8] ;offset dir
        push [bp+6] ;offset Lobby
        call lobbyscreen

        mov bx, [bp+8] ;offset dir
        mov al, [byte ptr bx]
        cmp al, 27d
        je loadstart

        cmp al, 'g'
        je startgame

    startgame:
        mov [byte ptr bx],0

        push [bp+18]
        push [bp+16]
        push [bp+14]
        call drawintermissionscreen1

        push [bp+30] ;Offset Currentnum
        push [bp+28] ;Offset CurrentSquare
        push [bp+26] ;Offset Constantnumbers
        push [bp+24] ;Offset Countnums
        push [bp+22] ;Offset Currentloc
        push [bp+20] ;Offset board
        call boardcreate

        mov di, [bp+28] ;Offset CurrentSquare
        mov bx, Startingsquare
        mov [di], bx
        mov bx, [bp+22] ;Offset Currentloc
        mov [byte ptr bx], 0
        mov di, [bp+30] ;Offset Currentnum
        mov bx, [bp+20] ;Offset board
        mov al, [byte ptr bx] ;First number on the board
        mov [byte ptr di], al ;Save it in the Currentnum variable

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
        pop di
        pop bx
        pop ax
        pop dx
        pop bp
        ret 36
    endp opening
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
   proc lobbyscreen
            ;This procedure prints the lobby screen and allows the player to call procedures that navigate between the rules and controls screens.
            ;In addition it allows the player to call procedures return to the opening screen or start the game

            ;Input: The offset of variables Lobby [bp+4], dir [bp+6], Controls [bp+8] and GameRules [bp+10]

            ;Output: The lobby screen
        push bp
        mov bp,sp
        push dx
        push ax
        push bx
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;  
    lobbys:
        mov dx,[bp+4] ;offset Lobby
        mov ah,09h
        int 21h
    lobbyoptions:
        xor ax,ax
	    mov ah,0						;If there is no input, move 0 into ah, and interrupt 16h in order to wait for a key to be pressed on the keyboared,
	    int 16h	
    jnz lobbyoptions

        cmp al, 27d
        je returntoOpening

        cmp al, 'c'
        je viewControls

        cmp al, 'e'
        je viewRules

        cmp al, 'g'
        je returntoOpening

        jmp lobbyoptions
    viewControls:

        push [bp+8] ;offset Controls
        call controlinfo
        jmp lobbys
    viewRules:

        push [bp+10] ;offset GameRules
        call InfoandRules
        jmp lobbys
    returntoOpening:
        mov bx, [bp+6] ;offset dir
        mov [byte ptr bx],al

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
        pop bx
        pop ax
        pop dx
        pop bp
        ret 8
    endp lobbyscreen
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;    
  proc controlinfo
            ;This procedure prints the control screen and allows the player to return to the lobby screen

            ;Input: The offset of the variable Controls [bp+4]

            ;Output: The controls screen
        push bp
        mov bp,sp
        push dx
        push ax
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;    
        mov dx,[bp+4] ;offset Controls
        mov ah,09h
        int 21h
    viewC:
        xor ax,ax
	    mov ah,0						;If there is no input, move 0 into ah, and interrupt 16h in order to wait for a key to be pressed on the keyboared,
	    int 16h	
    jnz viewC

        cmp al, 27d
        jne viewC

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
        pop ax
        pop dx
        pop bp
        ret 2
    endp controlinfo
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;   
  proc InfoandRules
            ;This procedure prints the rules screen and allows the player to return to the lobby screen

            ;Input: The offset of the variable GameRules [bp+4]

            ;Output: The Gamerules screen
        push bp
        mov bp,sp
        push dx
        push ax
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;    
        mov dx,[bp+4] ;offset GameRules
        mov ah,09h
        int 21h
    viewR:
        xor ax,ax
	    mov ah,0						;If there is no input, move 0 into ah, and interrupt 16h in order to wait for a key to be pressed on the keyboared,
	    int 16h	
    jnz viewR

        cmp al, 27d
        jne viewR

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
        pop ax
        pop dx
        pop bp
        ret 2
    endp InfoandRules
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
  proc drawintermissionscreen1
            ;This procedure prints the first pregame screen and calls the procedures that print the second pregame screen and the Sudoku board screen

            ;Input: The offset of variables Intermissionscreen1 [bp+4], Intermissionscreen2 [bp+6] and boardlength [bp+8]

            ;Output: The first pregame screen
        push bp
        mov bp,sp
        push dx
        push ax
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; 
        call delay
        mov dx,[bp+4]
        mov ah,09h
        int 21h
        call delay
        push [bp+6]
        call drawintermissionscreen2
        push [bp+8]
        call boarddraw
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
        pop ax
        pop dx
        pop bp
        ret 6
  endp drawintermissionscreen1
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;  
  proc drawintermissionscreen2
            ;This procedure prints the second pregame screen 

            ;Input: The offset of the variable Intermissionscreen2 [bp+4]

            ;Output: The second pregame screen
        push bp
        mov bp,sp
        push dx
        push ax
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; 
        call delay
        mov dx,[bp+4]
        mov ah,09h
        int 21h

        call delay
        call delay
        call delay
        call delay
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
        pop ax
        pop dx
        pop bp
        ret 2
    endp drawintermissionscreen2
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;    
    proc deletetheprevious
            ;This procedure changes the color of the players current location to orange(if there was a constant number in it)
            ;or grey if it was not a square were there was a constant number

            ;Input: The offset of variables Currentloc [bp+4], Currentnum [bp+6], constantcaught [bp+10], Currentsquare [bp+12]. 
                    ;In addtion to the offset of constantnumbers [bp+8] array

            ;Output: The digit on the players previous location on screen switches its color to the color orange(if there is a constant numebr in it) 
            ;or grey(if the latter) 
        push bp
        mov bp,sp
		push di
		push ax
		push si
        push bx
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
        push [bp+10] ;constantcaught
        push [bp+8]  ;constantnumbers
        push [bp+4]  ;currentloc
        call findconstants
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
        mov di, [bp+4] ;currentloc
        mov si, [bp+10] ;constantcaught
        mov bl, [byte ptr di]
        mov bh, 0
        mov al, [byte ptr bx]
        cmp [byte ptr si], 1
        je notplayernum
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
        mov ah, Grey
        jmp eraseplayerpointer
    notplayernum:
        mov ah, Orange
    eraseplayerpointer:
		mov si, [bp+12] ;currentsquare
        mov di, [si]
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
		mov [es:di], ax
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
        pop bx
		pop si
		pop ax
		pop di  
        pop bp
		ret 10
	endp deletetheprevious   
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    proc findconstants
            ;This procedure checks if the number in the current location the player is on is a constant number or not

            ;Input: The offset of variables Currentloc [bp+4] and Constantcaught [bp+8] In addition to the offset of constantnumbers [bp+6] array

            ;Output: None or the value 1 in the value of the offset of constantcuaght
        push bp
        mov bp, sp
        push bx
        push si
        push di
        push ax
        push cx
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
        mov bx, [bp+6] ;constantnumbers
        mov si, [bp+4] ;currentloc
        mov al, [byte ptr si]
        mov di, [bp+8] ;constantcaught
        mov ah, 0
    squareinterior:
        add bx,ax
    
        cmp [byte ptr bx],al
        je constant

        cmp [byte ptr bx], 'l'
        jne squareinterior

        mov [byte ptr di],0
        jmp endscan
    constant:
        mov [byte ptr di],1
    endscan:
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
        pop cx
        pop ax
        pop di
        pop si
        pop bx
        pop bp
        ret 6
    endp findconstants
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    proc enterKey
            ;This procedure recieve a digit from the player

            ;Input: The offset of variable dir [bp+4]

            ;Output: The digit of the key the player pressed on the keyboard in variable dir
        push bp
        mov bp,sp
        push ax
        push bx
    waitforkey:
        mov bx, [bp+4]
        xor ax,ax
        mov ah,0
        int 16h
        mov [byte ptr bx],al
        jnz waitforkey

        pop bx
        pop ax
        pop bp
        ret 2
    endp enterKey
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;  
    proc keys
            ;This procedure calls procedures that allow the player to move, input numbers on the sudoku board and leave the game. 

            ;It also calls the procedure that checks if the player has won or not

            ;Input: The offset of variables Currentloc [bp+4], Currentnum [bp+6], Currentsquare [bp+8], constantnumbers [bp+10], Constantncaught [bp+12], dir [bp+14],
                  ;Inputsignarray [bp+16], Mistakes [bp+18], Mistakescount [bp+20], Blockcatcher [bp+22], Youlost [bp+24], Board [bp+26], Youwon [bp+28], Victory [bp+30],
                  ;Victory2 [bp+32], numbers [bp+34], Nochange [bp+36]   

            ;Output: None
        push bp
        mov bp,sp
        push bx
        push di
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
        push [bp+14]
        call enterKey

        mov bx, [bp+14] 

        cmp [byte ptr bx], 'w'
        je W

        cmp [byte ptr bx], 'a'
        je A

        cmp [byte ptr bx], 's'
        je S

        cmp [byte ptr bx], 'd'
        je D

        cmp [byte ptr bx], 'q'
        je Putnumber

        jmp update
    W:
        push [bp+12];Constantcaught
        push [bp+10] ;The list of locations of numbers that are unremovable(if you try you will waste your time)
        push [bp+4] ;Currenlocation in board array
        push [bp+6];Current number
        push [bp+8] ;Current square on screen

        call up

        jmp update

    A:
        push [bp+12];Constantcaught
        push [bp+10] ;The list of locations of numbers that are unremovable(if you try you will waste your time)
        push [bp+4] ;Currenlocation in board array
        push [bp+6] ;Current number
        push [bp+8] ;Current square on screen

        call left

        jmp update

    S:
        push [bp+12];Constantcaught
        push [bp+10] ;The list of locations of numbers that are unremovable(if you try you will waste your time)
        push [bp+4] ;Currenlocation in board array
        push [bp+6];Current number
        push [bp+8] ;Current square on screen

        call down

        jmp update

    D:
        push [bp+12];Constantcaught
        push [bp+10] ;The list of locations of numbers that are unremovable(if you try you will waste your time)
        push [bp+4] ;Currenlocation in board array
        push [bp+6];Current number
        push [bp+8] ;Current square on screen

        call right

        jmp update
    Putnumber:
        push [bp+36] ;offset Nochange
        push [bp+16] ;offset Inputsignarray
        push [bp+12] ;Constantcaught
        push [bp+10] ;The list of locations of numbers that are unremovable(if you try you will waste your time)
        push [bp+4] ;Currentloc
        push [bp+6] ;Currentnum
        push [bp+8] ;Current square on screen
        call inputnum

        mov di, [bp+36] ;offset Nochange
        cmp [byte ptr di], 1
        je update

        push [bp+24] ;offset Youlost
        push [bp+22] ;offset Blockcatcher
        push [bp+6] ;Currentnum
        push [bp+20] ;offset Mistakescount
        push [bp+18] ;offset Mistakes
        push [bp+4] ;Currentloc

        call checkrow
    update:
        push [bp+14] ;offset dir
        push [bp+34] ;offset numbers
        push [bp+20] ;offset Mistakescount
        push [bp+32] ;offset Victory2
        push [bp+30] ;offset Victory
        push [bp+28] ;offset Youwon
        push [bp+26] ;offset board

        call Winsearch

        mov di, [bp+36] ;offset Nochange
        mov [byte ptr di], 0
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
        pop di
        pop bx
        pop bp
        ret 34
    endp keys
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    proc up
            ;This procedure moves the player one square up

            ;Input: The offset of variables Currentsquare [bp+4], Currentnum [bp+6], Curretnloc [bp+8], constantcatcher [bp+12] and Constantnumbers [bp+10] array

            ;Output: The players location within the board array and on the screen has moved one square up
        push bp
        mov bp, sp
        push di
        push bx
        push si
        push ax
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
        push [bp+4] ;currentsquare
        push [bp+12] ;constant catcher
        push [bp+10] ;constant numbers
        push [bp+6] ;currentnum
        push [bp+8] ;currentloc
        call deletetheprevious
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
        mov si, [bp+4] ;currentsquare
        mov di, [si]
        sub di, Rowspace
        cmp di, Startingsquare
        jl nomov
        mov [si],di
        mov di, [bp+8]
        mov bl, [byte ptr di]
        mov bh, 0
        sub bl, 9
        cmp bl, 0
        jb nomov
        mov al, [byte ptr bx]
        mov [byte ptr di], bl
        mov di, [bp+6] ;currentnum
        mov [byte ptr di], al
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    nomov:
        pop ax
        pop si
        pop bx
        pop di
        pop bp
        ret 10
    endp up
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    proc left 
			;This procedure moves the player one square to the left

            ;Input: The offset of variables Currentsquare [bp+4], Currentnum [bp+6], Curretnloc [bp+8], Constantnumbers [bp+10] and constantcatcher [bp+12]

            ;Output: The players location within the board array and on the screen has moved one square to the left
		push bp
		mov bp,sp
	    push di
        push bx
        push si
        push ax
        push cx
        push dx
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
        push [bp+4] ;currentsquare
        push [bp+12]
        push [bp+10]
        push [bp+6]
        push [bp+8]
        call deletetheprevious
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
        mov si, [bp+4]
        mov di, [si]
        sub di, 4
        mov cx, Rowspace
        xor dx,dx
        xor ax,ax
        mov ax, di
        div cx

        cmp dx, 68d
        jl nomov2

        cmp di, Startingsquare
        jl nomov2
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
        mov [si],di
        mov di, [bp+8]
        mov bl, [byte ptr di]
        mov bh, 0
        dec bl
        cmp bl, 0
        jb nomov2
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
        mov di, [bp+8]
        mov al, [byte ptr bx]
        mov [byte ptr di], bl
        mov di, [bp+6]
        mov [byte ptr di], al
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    nomov2:

        pop dx
        pop cx
        pop ax
        pop si
        pop bx
        pop di
		pop bp
		ret 10
	endp left
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    proc down
            ;This procedure moves the player one square down

            ;Input: The offset of variables Currentsquare [bp+4], Currentnum [bp+6], Curretnloc [bp+8], Constantnumbers [bp+10] and constantcatcher [bp+12]

            ;Output: The players location within the board array and on the screen has moved one square down
        push bp
        mov bp, sp
        push di
        push si
        push bx
        push ax
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
        push [bp+4] ;currentsquare
        push [bp+12]
        push [bp+10]
        push [bp+6]
        push [bp+8]
        call deletetheprevious
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
        mov si, [bp+4]
        mov di, [si]
        add di, Rowspace
        cmp di, LastLoc
        ja nomov1
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
        mov [si],di
        mov di, [bp+8]
        mov bl, [byte ptr di]
        mov bh, 0
        add bl, 9
        cmp bl, Lastsquare
        ja nomov1
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
        mov al, [byte ptr bx]
        mov [byte ptr di], bl
        mov di, [bp+6]
        mov [byte ptr di], al
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    nomov1:

        pop ax
        pop bx
        pop si
        pop di
        pop bp
        ret 10
    endp down
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    proc right 
            ;This procedure moves the player one square to the right

            ;Input: The offset of variables Currentsquare [bp+4], Currentnum [bp+6], Curretnloc [bp+8], Constantnumbers [bp+10] and constantcatcher [bp+12]

            ;Output: The players location within the board array and on the screen has moved one square to the right of the previous location
        push bp
        mov bp,sp
        push di
        push bx
        push si
        push ax
        push cx
        push dx
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
        push [bp+4] ;currentsquare
        push [bp+12]
        push [bp+10]
        push [bp+6]
        push [bp+8]
        call deletetheprevious
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
        mov si, [bp+4]
        mov di, [si]
        add di, 4
        mov cx, Rowspace
        xor dx,dx
        xor ax,ax
        mov ax, di
        div cx
        cmp dx, 102d
        ja nomov3 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
        mov [si],di
        mov di, [bp+8]
        mov bl, [byte ptr di]
        mov bh, 0
        inc bl
        cmp bl, 0
        jb nomov3
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
        mov al, [byte ptr bx]
        mov [byte ptr di], bl
        mov di, [bp+6]
        mov [byte ptr di], al
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    nomov3:
        pop dx
        pop cx
        pop ax
        pop si
        pop bx
        pop di
        pop bp
        ret 10
	endp right
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    proc continuegame
         ;This procedure updates the game according to the players actions

         ;Input: The offset of variables Currentsquare [bp+4], Currentnum [bp+6], 

         ;Output: None
      push bp
      mov bp,sp
      push ax
      push si
      push di
      push bx
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;     
      mov di, [bp+16]
      mov si, [bp+14]
      cmp [byte ptr si], 1 ;Did the player win?
      je continuethegame
      cmp [byte ptr di], 1 ;Did the player not lose?
      jne continuethegame
      mov bx, [bp+18]
      mov [byte ptr bx], 27d
 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;      
      push [bp+12]
      push [bp+10]
      push [bp+8]
      call Defeat
    continuethegame:
      mov bx, [bp+18]
      cmp [byte ptr bx], 27d
      je Playerexit
      push [bp+6]
      push [bp+4]
      call drawpointer
    Playerexit:
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
      pop bx
      pop di
      pop si
      pop ax
      pop bp
      ret 16
    endp continuegame
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    proc drawpointer
            ;This procedure draws the digit of the location the player is on in the sudoku board, in the color blue

            ;Input: The offset of variables Currentnum [bp+6] and Currentsquare [bp+4]

            ;Output: The digit in the players location on the screen (address [es:di]) is colored in blue 
      push bp
      mov bp,sp
      push ax
      push si
      push di
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;     
      mov si, [bp+4]
      mov di, [bp+6]
      mov al, [byte ptr di]
      mov ah, Blue
      mov di, [si]
      mov [es:di], ax
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
      pop di
      pop si
      pop ax
      pop bp
      ret 4
    endp drawpointer
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    proc inputmodeOn
            ;This procedure prints the input text on screen in the color red

            ;Input: The offset of array Inputsignarray [bp+4]

            ;Output: The text "Input" colored in red on the screen (address [es:di])
        push bp
        mov bp,sp
        push di
        push ax
        push bx
        push cx
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
        mov di, Inputsignloc
        mov bx, [bp+4]
        mov ah, Red
        mov cx, 5
    TurnsignOn:
        mov al, [byte ptr bx]
        mov [es:di], ax
        inc bx
        add di,2
        dec cx
        cmp cx,0
        jne TurnsignOn
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
        pop cx
        pop bx
        pop ax
        pop di
        pop bp
        ret 2
    endp inputmodeOn
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    proc inputnum
            ;This procedure allows the player to input a number in an empty square on the sudoku board

            ;Input: The offset of Currentloc [bp+8], Currentnum [bp+6], Currentsqaure [bp+4], 

            ;Output: The digit the player pressed on the keyboard, an empty square or nothing if the player tried to change a constantnumber
        push bp
        mov bp,sp
        push si
        push ax
        push di
        push bx
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
        push [bp+14]
        call inputmodeOn
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
        push [bp+12]
        push [bp+10]
        push [bp+8] ;currentloc
        call findconstants ;if the player is trying to change a constant number the input will not be accepted 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
        mov si, [bp+12]
        cmp [byte ptr si], 1
        jne canInput ;if the player wasnt trying to change an unchangable number th code will return to its normal procedure, unless the contrary 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
        mov si, [bp+4] ;if the contrary occurs, the code will input the number again
        mov di, [bp+8] ;offset currentloc
        mov bl, [byte ptr di]
        mov bh,0
        mov al, [byte ptr bx]
        mov di, [bp+6] ;offset currentnum
        mov [byte ptr di], al
        cmp [byte ptr di], '_'
        je canInput
        jmp noNewInput
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    canInput:
        mov si, [bp+4] ;offset currentsquare
        mov bx, [bp+6] ;offset currentnum
        xor ax, ax
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    waitfornum:
        mov ah,0						;If there is no input, move 0 into ah, and interrupt 16h in order to wait for a key to be pressed on the keyboared,
		int 16h	
        jnz waitfornum
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    noNewInput:
        mov di, [si]
        mov ah, Blue

        cmp al, 'o' ;If 'o' is pressed on the keyboard erase the number in that location
        je erase

        cmp al, '1'
        je num

        cmp al, '2'
        je num

        cmp al, '3'
        je num

        cmp al, '4'
        je num

        cmp al, '5'
        je num

        cmp al, '6'
        je num

        cmp al, '7'
        je num

        cmp al, '8'
        je num

        cmp al, '9' ; all of the numbers not including 0 and the letter o can be inputed, if inputed 
        je num

        jmp returntokeys
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    num:
        mov [es:di], ax
        mov [byte ptr bx], al ;al holds the digit
        mov di, [bp+8] ;offset currentloc
        mov bl, [byte ptr di] ;the reason for these to moves is the pointer difference, di's data holds the location value and data in that location holds the digit
        mov bh,0
        mov [byte ptr bx], al ;input the digit in the board array
        jmp noinput
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    erase:
        mov al, '_'      ;input an empty square(defined as '_')
        mov [es:di], ax ;input it on the screen
        mov [byte ptr bx], al 
        mov di, [bp+8]
        mov bl, [byte ptr di]
        mov [byte ptr bx], al
        mov bx, [bp+16]
        mov [byte ptr bx], 1
        jmp noinput
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    returntokeys:
         mov al, [byte ptr bx]
         mov di, [bp+8]
         mov bh,0
         mov bl, [byte ptr di]
         mov [byte ptr bx], al
         mov bx, [bp+16]
         mov [byte ptr bx], 1
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    noinput:
         push [bp+14]
         call inputmodeOf
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
        pop bx
        pop di
        pop ax
        pop si
        pop bp
        ret 14
    endp inputnum
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    proc inputmodeOf
            ;This procedure prints "Input" on screen in the color grey

            ;Input: The offset of array Inputsignarray [bp+4]

            ;Output: The text "Input" colored in grey on the screen (address [es:di])
        push bp
        mov bp,sp
        push di
        push ax
        push bx
        push cx
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
        mov di, Inputsignloc
        mov bx, [bp+4]
        mov ah, Grey
        mov cx, 5
    TurnsignOf:
        mov al, [byte ptr bx]
        mov [es:di], ax
        inc bx
        add di,2
        dec cx
        cmp cx,0
        jne TurnsignOf
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
        pop cx
        pop bx
        pop ax
        pop di
        pop bp
        ret 2
    endp inputmodeOf
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    proc checkrow 
            ;This procedure checks if the player has placed a number that already appears in the current row they are in

            ;Input: The offset of variables Currentloc [bp+4], Currrentnum [bp+10], Mistakescount[bp+8] and Youlost [bp+14]
                    ;In addition the offsets of Mistakes [bp+6] and blockcatcher [bp+12] arrays

            ;Output: None
        push bp
        mov bp, sp
        push di
        push si
        push bx
        push cx
        push ax
        push dx
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
        mov si, [bp+10] ;Offset currentnum
        mov di, [bp+4]; offset currentloc
        mov bh,0
        mov ah,0
        mov bl, [byte ptr di] ;[Currentloc]
        mov al, [byte ptr bx] ;[Currentnum]
        mov [byte ptr si], al
        mov cl, 9
        cmp bx,0 ;if not zero search for start of row
        je preparecheck
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    searchStartRow:
        mov ah,0
        cmp bx,0
        je preparecheck
        mov ax, bx
        div cl
        cmp ah, 0
        je preparecheck
        dec bx
    jmp searchStartRow
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    preparecheck:
        mov al, [byte ptr si]
        mov ah,0
        mov dx, 0
        mov cx, 8
        mov bh,0
        dec bx
    row:   
        inc bx
        cmp al, [byte ptr bx]
        je MistakeorNot
        dec cx
        cmp cx,0
        jne row
        jmp endit
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    MistakeorNot:
        inc dx
        cmp dx, 1
        jna row
        push [bp+14]
        push [bp+8]
        push [bp+6]
        call Playermistake
        jmp noDouble
    endit:
         push [bp+14]
         push [bp+12]
         push [bp+10]
         push [bp+8]
         push [bp+6]
         push [bp+4]
         call checkcolumn
    noDouble:
        pop dx
        pop ax
        pop cx
        pop bx 
        pop si
        pop di
        pop bp
        ret 12
    endp checkrow
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
     proc checkcolumn
            ;This procedure checks if the player has placed a number that already appears in the current column they are in

            ;Input: The offset of variables Currentloc [bp+4], Currrentnum [bp+10], Mistakescount[bp+8] and Youlost [bp+14]
                    ;In addition the offsets of Mistakes [bp+6] and blockcatcher [bp+12] arrays

            ;Output: None
        push bp
        mov bp, sp
        push di
        push si
        push bx
        push cx
        push ax
        push dx
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
        mov si, [bp+10]; offset currentnum
        mov di, [bp+4]; offset currentloc
        mov bh,0
        mov ah,0
        mov bl, [byte ptr di] ;[Currentloc]
        mov al, [byte ptr bx] ;[Currentnum]
        mov [byte ptr si], al 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    searchStartcolumn:
       sub bx, 9
       cmp bx,0
       jl preparecheck1
    jmp searchStartcolumn
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    preparecheck1:
        mov ah,0
        mov dx, 0
        mov cx, 8
    column:   
        add bx,9
        cmp al, [byte ptr bx]
        je MistakeorNot1
        dec cx
        cmp cx,0
        jne column
        jmp endcheck1
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    MistakeorNot1:
        inc dx
        cmp dx, 1
        jna column
         push [bp+14]
         push [bp+8]
         push [bp+6]
         call Playermistake
         jmp noDouble1
   endcheck1:
           push [bp+14]
           push [bp+12]
           push [bp+10]
           push [bp+8]
           push [bp+6]
           push [bp+4]
           call checkblock
   noDouble1:
        pop dx
        pop ax
        pop cx
        pop bx 
        pop si
        pop di
        pop bp
        ret 12
    endp checkcolumn
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    proc checkblock
            ;This procedure checks if the player has placed a number that already appears in the current block he is on

             ;Input: The offset of variables Currentloc [bp+4], Currrentnum [bp+10], Mistakescount[bp+8] and Youlost [bp+14]
                    ;In addition the offsets of Mistakes [bp+6] and blockcatcher [bp+12] arrays

            ;Output: None
        push bp
        mov bp,sp
        push di
        push si
        push bx
        push dx
        push cx
        push ax
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
        mov si, [bp+10]
        mov di, [bp+4]; offset currentloc
        mov bh,0
        mov ah,0
        mov bl, [byte ptr di] ;[Currentloc]
        mov al, [byte ptr bx] ;[Currentnum] This is due to fact each address between 0-80 holds the ASCII value of the digit in it
        mov [byte ptr si], al
        mov si, [bp+12]
        mov ch,0
        cmp bx, 0
        je preparecheck3
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
        add si, bx
        mov bl, 0
        mov cl, [byte ptr si]
        mov si, [bp+12]
    searchForblockstart:
        cmp cl, [byte ptr si]
        je preparecheck3
        inc bl
        inc si
        jmp searchForblockstart
    preparecheck3:
        mov bh, 0
        mov si,[bp+10]
        mov al,[byte ptr si]
        mov ah,0
        mov dx, 0
        mov cx, 9
        dec bx
        jmp rowblock
    preparecheck4:
        add bx,6
    rowblock:   
        inc bx
        mov bh,0
        cmp al, [byte ptr bx]
        je MistakeorNot4
    continuecheck: ;after counting the number at its first apperance we return to check if it appears more then once 
        dec cx
        cmp cx,6
        je preparecheck4
        cmp cx,3
        je preparecheck4
        cmp cx,0
        jne rowblock
        jmp endallchecks
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    MistakeorNot4:
        inc dx
        cmp dx, 1
        ja mistakenwithin
        jmp continuecheck ;Continue checking
    mistakenwithin: ;If the number appears twice in the same block
        push [bp+14]
        push [bp+8]
        push [bp+6]
        call Playermistake
    endallchecks:   
        pop ax
        pop cx
        pop dx
        pop bx 
        pop si
        pop di
        pop bp
        ret 12
    endp checkblock
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    proc Playermistake
            ;This procedure increases  the current number of mistakes the player has made by 1

            ;Input: The offset of variables Youlost ([bp+8]), Mistakescount ([bp+6]) and Mistakes ([bp+4])

            ;Output: The updated number of mistakes on in the address [es:di] and the value of the offset of variable Mistakescount 
        push bp
        mov bp, sp
        push ax
        push di
        push si
        push bx
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
        mov bx, [bp+8] ;Youlost
        mov di, [bp+6] ;Mistakescount
        mov si, [bp+4] ;Mistakes array
        mov al, [byte ptr di]
        inc al
        cmp al, 3
        jne continue1
        mov [byte ptr bx],1
    continue1:
        mov ah, 0
        mov [byte ptr di], al
        add si, ax
        mov al, [byte ptr si]
        mov ah, Grey
        mov di, Mistakesloc
        mov [es:di], ax
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
        pop bx
        pop si
        pop di
        pop ax
        pop bp
        ret 6
    endp Playermistake
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    proc randomlocation
            ;This procedure finds a random location between 0-80 and stores it in the offset of variable Currentloc

            ;Input: Offset of variables Currentloc ([bp+6]) and board ([bp+4])

            ;Output: A random location between 0-80 in the value of the offset of variable Currentloc
        push bp
        mov bp, sp
        push di
        push bx
        push ax
        push dx
        push cx
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
        mov di, [bp+6] ;offset of the Currentloc
        mov bx, [bp+4] ;offset of board array
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    randomLoc:
            xor ax, ax
            xor cx,cx
            int 1ah ;This gives registers dx and cx the values of the current time, dx recieves the current time in seconds(hours and minutes) 
            sal dx, 10d ;In order to to make dx the value in milliseconds we will sal dx once, if you want more do more.
            add dx, cx ;Add current hour to dx
            mov ax, dx ; move the value in milliseconds to ax
            xor dx,dx
            mov cx, 81d
            div cx

            cmp dx, Lastsquare
            ja randomLoc

            mov bx, dx
            mov bh,0
            cmp [byte ptr bx], '_' ;did we already erase a number here? if yes then look for a location with a number
            je randomLoc

            mov [byte ptr di], bl ;update the current location
            mov al, '_' ;mov '_' to al
            mov [byte ptr bx],al ;delete the number within the selected location
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
        pop cx
        pop dx
        pop ax
        pop bx
        pop di
        pop bp
        ret 4
    endp randomlocation
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    proc boardcreate
            ;This procedure creates an unsolved board by deleting numbers at random from the board array.

            ;Input: variables countnums, currentloc, board and constant numbers

            ;Countnums counts the number of numbers that will be erased, board is used to point at locations in it via its offset([bp+4])

            ;Output: An unsolved sudoku board array and a constantnumbers array with some locations be free to use by the player(by inputing 'l')
        push bp
        mov bp,sp
        push di
        push cx
        push bx
        push ax
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
        creator:
            push [bp+6] ;offset Currentloc
            push [bp+4] ;offset Board
            call randomlocation ;Choose a random location to erase on the board array.
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
            push [bp+10] ;Constantnumbers 
            push [bp+6]  ;Currentloc
            call removeconstant ;Remove the constant numbers location from the array of constant numbers

            mov di, [bp+8] ;Offset Countnums
            mov cl, [byte ptr di] ;cl recieves the current value stored in variable countnums
            mov ch,0 ;The procedure makes sure ch doesn't hold any previous values
            inc cl   ;The procedure increments the value of cl, in order to update the value stored in countnums

            mov [byte ptr di], cl ;Update Countnums

            cmp cl, 52d
            je intervention

            jmp creator
      intervention:
            mov [byte ptr di], 0
            mov di, [bp+12] ;Currentsquare
            mov bx, Startingsquare
            mov [di], bx
            mov di, [bp+14] ;Currentnum
            mov bx, [bp+4] ;Board
            mov al, [byte ptr bx]
            mov [byte ptr di],al

            push [bp+10] ;Constantnumbers
            push [bp+12] ;Currentsqaure
            push [bp+4] ;Board array
            call printboardNums
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
        pop ax
        pop bx
        pop cx
        pop di
        pop bp
        ret 12
    endp boardcreate
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    proc removeconstant
                 ;This procedure removes a location within the constantnumbers array, and makes it available for use to the player

                 ;The procedure does this by placing 'l' into the value of an address in constantnumbers array, which its distance from the address of the offset 
                 ;of constantnumbers array is equal to the value in the offset of Currentloc

                 ;By that the all locations in array constantnumbers are symmetrical to the locations board array
                
                 ;Input: The offset of variables Currentloc [bp+4] and constantnumbers [bp+6]

                 ;Output: A location that doesn't hold a constant number 
        push bp
        mov bp,sp
        push di
        push si
        push ax
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
        mov si, [bp+6] ;constantnumbers
        mov di, [bp+4] ;currentloc
        mov al, [byte ptr di] ;move the Currentlocation to al
        mov ah, 0 ;Clear ah from garbage
        add si, ax ;Si will now point to the location that is simetrical to that of currentloc's value
        mov [byte ptr si], 'l' ;Erase the location by placing 'l' in that location within the array of constantnumbers
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
        pop ax
        pop si
        pop di
        pop bp
        ret 4
    endp removeconstant
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    proc printboardNums 
            ;This procedure prints all numbers in the array board on the screen

            ;This is done via going over both board array, and the physical board on screen. 
            
            ;In a way that associates each location on screen with its location in the array.

            ;Basicly the ratio of the space between locations on the array compared with locations on the screen is around verticaly 1 to 4

            ;And the ratio horizontly is 9 to 160

            ;While this happens constant numbers array fills itself up with the digits stored in board array

            ;Input: The offset of Board [bp+4] and constantnumbers [bp+8] arrays.
                    ;In addition to the offset of variable Currentsquare [bp+6].

            ;Output: All the numbers in all addresses of the board array that have constant numbers on the sudoku board symmetricaly to their locations 
                    ;in board array
        push bp
        mov bp, sp
        push si
        push di
        push ax
        push cx
        push bx
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
        mov bx, [bp+4] ;Offset Board
        mov si, [bp+6] ;offset currentsqaure
        mov di, [si] ;Move the value of the currentsquare to di
        mov si, [bp+8] ;Offset constant numbers
        dec bx ;Make sure bx checks location 0(otherwise bx=0 would have been skipped)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    printall:
        inc bx  
        mov bh,0
        mov cl, 9d ;all first locations of each row are divisions of 9

        cmp bx, 0
        je print

        cmp bx, Lastsquare
        ja go

        mov ax, bx ;move the current location bx points on in the array
        div cl 

        cmp ah, 0 ;if we have entered a new line then move to the next line
        je nextline1
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    print:
        mov bh,0  ;make sure bx has not crossed the array
        mov al, [byte ptr bx] ;move the number in bx to al
        mov ah, orange    ;Ah holds the color orange

        cmp [byte ptr si], 'l' ;there is no need to print empty squares on the board
        je noneedforprint

        mov [es:di], ax ;The constant number will be inputed on di's location on the screen
        mov [byte ptr si], bl   ;bl will be moved into the location si points on in array Constantnumbers
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    noneedforprint: ;If a sqaure is empty there is no need to print anything on it, a sudoku board has no need to be so colorful 

        inc si      ;si will move forward to point on the next location within the constant numbers array
        add di, 4   ;di will move to the next location on the screen
        jmp printall
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    nextline1:
        add di, Rowspace ;Move di to the next row on the screen

        sub di, 36d  ;Return it to the start of the row on the screen

        cmp bx, 80d ;if the bx points onto a location outside of the board array then end the printing procedure
        ja go

        cmp di, LastLoc ;If di's value is larger then that of the last location of the board on the screen then end the printing procedure
        ja go

        jmp print ;Continue the printing procedure
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    go:
        pop bx
        pop cx
        pop ax
        pop di
        pop si
        pop bp
        ret 6
    endp printboardNums 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    proc Winsearch
            ;This procedure checks whether the player has won, lost or neither

            ;Input: The offset of board [bp+4] and numbers [bp+14] arrays.
                    ;In addition the offset of variables Youwon [bp+6], Victory [bp+8], Victory2 [bp+10], Mistakescount [bp+12] and dir [bp+16]

            ;Output: None or 27d in the value of the offset of variable dir (which ends the game)
        push bp
        mov bp,sp
        push cx
        push bx
        push di
        push si
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
        mov di, [bp+12]
        mov si, [bp+14]
        dec si
        cmp [byte ptr di],3
        je notfull
    checknums:
        mov bx, [bp+4]
        inc si
        mov cx,0
        cmp si, '$'
        je victorys
    Fillcheck:

        mov al, [byte ptr bx]
        cmp [byte ptr si], al
        jne noappear
        inc cx
        cmp cx, 9
        ja notfull
    noappear:
        cmp bx, Lastsquare
        je checknums

        cmp [byte ptr bx], '_'
        je notfull

        inc bx

    jmp Fillcheck
    victorys:
        mov di, [bp+6]
        mov [byte ptr di], 1
        push [bp+10]
        push [bp+8]
        call Win
        mov bx, [bp+16]
        mov [byte ptr bx], 27d
    notfull:
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
        pop si
        pop di
        pop bx
        pop cx
        pop bp
        ret 14
    endp Winsearch
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    proc RestartGame
            ;This procedure resets the game Board and Constantnumbers array's

            ;The procedure does this via using a copy of the board before numbers where erased from it and placing them according to order in the board array

            ;And by placing 0's in the all locations the array constantnumbers takes hold of in the memory and varaible mistakecounter

            ;Input: The offset of arrays BoardClone[bp+4], Board[bp+6], Constantnumbers[bp+8].
            ;The offset of variables Youwon, Youlost and Mistakescount

            ;Output: The values in the offsets of variables Youlost, Youwon and Mistakescount is equal to 0
        push bp
        mov bp,sp
        push bx
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

        mov bx, [bp+14]
        mov [byte ptr bx],0

        mov bx, [bp+12]
        mov [byte ptr bx],0

        mov bx, [bp+10]
        mov [byte ptr bx],0

        push [bp+6]
        push [bp+4]
        call Restartboard

        push [bp+8]
        call Removeallconstants

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
        pop bx
        pop bp
        ret 12
    endp RestartGame
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    proc Restartboard
            ;This procedure copies all of the values in all of the address in Boardclone array to the values of the address of the board array

            ;Input: The offset of board [bp+4] and BoardClone array [bp+6]

            ;Output: The board array that holds all of the numbers that are in Boardclone array symmetricaly
        push bp
        mov bp,sp
        push di
        push bx
        push ax
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
        mov di, [bp+6]
        mov bx, [bp+4]
        dec bx
    Recreateboard:
        inc bx
        mov bh,0
        mov al, [byte ptr di]
        mov [byte ptr bx],al
        inc di

        cmp bx, Lastsquare
        jne Recreateboard
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
        pop ax
        pop bx
        pop di
        pop bp
        ret 4
    endp Restartboard
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    proc Removeallconstants
            ;This procedure marks all locations of the constantnumbers array as locations that don't have a constant number

            ;By moving the value 0 into all of the address of the constatnumbers array

            ;Input: The offset of constantnumbers array [bp+4]

            ;Output: A constantnumbers array that has no locations marked as a location with a constant number
        push bp
        mov bp,sp
        push bx
        push cx
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
        mov cx,0
        mov bx, [bp+4]
    Resetconstants:
        mov [byte ptr bx],0
        inc bx
        inc cx

        cmp cx, Lastsquare
        jne Resetconstants
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
        pop cx
        pop bx
        pop bp
        ret 2
    endp Removeallconstants
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    proc Win    
            ;This procedure prints the victory screens

            ;Input: The offset of variables Victory [bp+4] and Victory2 [bp+6]

            ;Output: The victory screens
        push bp
        mov bp,sp
        push dx
        push ax
        
        mov dx,[bp+4]
        mov ah,09h
        int 21h

        call delay
        call delay

        mov dx,[bp+6]
        mov ah,09h
        int 21h
        
        
        call delay
        call delay
        
        pop ax
        pop dx
        pop bp
        ret 4
    endp Win
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    proc Defeat  
            ;This procedure prints the defeat screens

            ;Input: The offset of variables Lose [bp+4], Lose2 [bp+6] and Lose3 [bp+8]

            ;Output: The defeat screens 
        push bp
        mov bp,sp
        push dx
        push ax
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
        mov dx,[bp+4]
        mov ah,09h
        int 21h

        call delay

        call delay

        call delay

        call delay

        mov dx,[bp+6]
        mov ah,09h
        int 21h
     
        call delay

        call delay

        call delay

        call delay

        mov dx,[bp+8]
        mov ah,09h
        int 21h

        call delay

        call delay

        call delay

        call delay
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; 
        pop ax
        pop dx
        pop bp
        ret 6
    endp Defeat

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;==================================================================================================================;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; M A I N ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;------------------------------------------------------------------------------------------------------------------;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
start:

	mov ax,@data							
	mov ds, ax
	mov ax, 0b800h								
	mov es,ax
	xor ax, ax

    call blackscreen						;Clear the trash on the screen

startit:

    push offset Youwon  ;[bp+38]   
    push offset Mistakescount ;[bp+36]
    push offset Youlost ;[bp+34]
    push offset BoardClone ;[bp+32]
    push offset Currentnum ;[bp+30]
    push offset CurrentSquare ;[bp+28]
    push offset constantnumbers ;[bp+26]
    push offset countnums ;[bp+24]
    push offset Currentloc ;[bp+22]
    push offset Board ;[bp+20]
    push offset Boardlength ;[bp+18]
    push offset Intermission2 ;[bp+16]
    push offset Intermission1 ;[bp+14]
    push offset Gamerules ;[bp+12]
    push offset Controls ;[bp+10]
    push offset dir ;[bp+8]
    push offset Lobby ;[bp+6]
    push offset openingscreen ;[bp+4]   

    call opening             ;Draw the Opening screen

game:
        push offset dir
        push offset Youlost
        push offset Youwon
        push offset Lose3
        push offset Lose2
        push offset Lose
        push offset Currentnum
        push offset CurrentSquare

        call continuegame ;Continue the game according to the players actions

        cmp [dir], 27d
        jne continue

        mov [dir],0
        jmp startit ;If otherwise the player will return to the opening screen
    continue:

        push offset Nochange ;[bp+36]
        push offset numbers ;[bp+34]
        push offset Victory2 ;[bp+32]
        push offset Victory ;[bp+30]
        push offset Youwon ;[bp+28]
        push offset Board ;[bp+26]
        push offset Youlost ;[bp+24]
        push offset Blockcatcher ;[bp+22]
        push offset Mistakescount ;[bp+20]
        push offset Mistakes ;[bp+18]
        push offset Inputsignarray ;[bp+16]
        push offset dir	;[bp+14]	
        push offset constantcaught ;[bp+12]
        push offset constantnumbers ;[bp+10]
        push offset Currentsquare ;[bp+8]
        push offset Currentnum ;[bp+6]
        push offset Currentloc ;[bp+4]

        call keys ;Move, input on board, win or leave

jmp game 
     
exit:

	mov ax, 4c00h

	int 21h

END start