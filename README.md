### Doodle.io

![start_menu_edited](https://github.com/jing-xiang/FPGA/assets/61624545/058e192d-4d72-4f9c-8ddf-9a8af67dd7db)

![photo_2024-04-13_15-17-16](https://github.com/jing-xiang/FPGA/assets/61624545/12432175-5ab8-4758-9996-4e4bcaf7f9d2)

Doodle.io is a fun and interactive drawing game inspired by the popular   online game skribbl.io, designed to run on two Basys 3 FPGA boards. 
Each round runs the guessing and drawing phases simultaneously. The drawer is determined by having SW0 turned on, while the guesser is determined by having SW15 turned on. Once programmed, the round immediately starts.

In each round, Player A (drawer) uses the mouse to draw on the top OLED display based on a given word prompt that is displayed on the bottom OLED. A timer starts at 60 seconds on the 7-segment display on Player’s B board (guesser), during which Player A must try to convey a word or phrase to Player B through their drawing. Player A can use the OLED display to sketch their masterpiece, utilizing the Basys 3's mouse input functionality.

At the same time, the guessing phase also runs. Player B has 60 seconds to guess the word or phrase based on Player A's drawing which is viewable on the 2nd Basys board via UART. Player B uses the keyboard input on the other Basys 3 to enter their guess, whereby the keyboard input is shown on another OLED along with hints. The OLED also indicates if the guess is correct or wrong via color coding. If player B successfully guesses, the timer stops. If the guess is correct or the timer runs out, both player A and B has to press btnR to proceed to the next round.

In conclusion, Doodle.io offers a lively and engaging experience, blending drawing and guessing seamlessly on two Basys 3 FPGA boards, making it a delightful adaptation of the beloved skribbl.io game.

Credits: 
Leong Deng Jun
He Shaoliang
Mukund Ayagari
Chew Jing Xiang
