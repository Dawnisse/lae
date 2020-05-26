//
// More realistic implementation of UART TX unit using a Finite State Machine (FSM).
// The block only transmits one BYTE and is foreseen to be interfaced with a FIFO.
//
// Luca Pacher - pacher@to.infn.it
// Spring 2020
//


//
//   __________________       _____ _____ _____ _____ _____ _____ _____ _____ _____ ___________
//                     \_____/_____X_____X_____X_____X_____X_____X_____X_____X     :
//
//         IDLE        START  BIT0  BIT1  BIT2  BIT3  BIT4  BIT5  BIT6  BIT7  STOP  IDLE
//
//


`timescale 1ns / 100ps

module uart_tx_FSM (

   input  wire clk,              // on-board 100 MHz system clock
   input  wire reset,            // active-high, synchronous reset
   input  wire tx_start,         // start of transmission (e.g. a push-button or a single-clock pulse flag, more in general from a FIFO-empty flag)
   input  wire tx_en,            // baud-rate "tick", single clock-pulse asserted once every 1/(9.6 kHz)
   input  wire [7:0] tx_data,    // byte to be trasmitted over the serial lane
   output wire tx_busy,          // ongoing data transmission
   output reg  TxD               // serial output stream

   ) ;


   ///////////////////////////////
   //   FSM states definition   //
   ///////////////////////////////

   parameter [3:0] IDLE  = 4'h0 ;
   parameter [3:0] START = 4'h1 ;
   parameter [3:0] BIT0  = 4'h2 ;
   parameter [3:0] BIT1  = 4'h3 ;
   parameter [3:0] BIT2  = 4'h4 ;
   parameter [3:0] BIT3  = 4'h5 ;
   parameter [3:0] BIT4  = 4'h6 ;
   parameter [3:0] BIT5  = 4'h7 ;
   parameter [3:0] BIT6  = 4'h8 ;
   parameter [3:0] BIT7  = 4'h9 ;
   parameter [3:0] STOP  = 4'hA ;

   reg [3:0] STATE, NEXT_STATE ;



   /////////////////////////////
   //   FSM sequential part   //
   /////////////////////////////

   always @(posedge clk) begin

      if(reset == 1'b1)
         STATE <= IDLE ;     // synchronous reset      

      else
         STATE <= NEXT_STATE ;
   end


   ////////////////////////////////
   //   FSM combinational part   //
   ////////////////////////////////

   always @(*) begin

      TxD = 1'b1 ;                  // by default, keep high the TX lane

      case(STATE)

         default : if(tx_en) NEXT_STATE <= IDLE ;     // catch-all condition

         IDLE : begin

            TxD = 1'b1 ;

            if(tx_start)
               NEXT_STATE = START ;         // start the transaction
            else
               NEXT_STATE = IDLE ;
         end

         //_________________________________________
         //

         START : begin

            TxD = 1'b0 ;                    // assert START bit to 1'b0 as requested by RS232 protocol

            if(tx_en == 1'b1)
               NEXT_STATE = BIT0 ;
            else
               NEXT_STATE = START ;
         end

         //_________________________________________
         //

         BIT0 : begin

            TxD = tx_data[0] ;             // send the LSB first as requested by RS232 protocol

            if(tx_en == 1'b1)
               NEXT_STATE = BIT1 ;
            else
               NEXT_STATE = BIT0 ;
         end

         //_________________________________________
         //

         BIT1 : begin

            TxD = tx_data[1] ;

            if(tx_en == 1'b1)
               NEXT_STATE = BIT2 ;
            else
               NEXT_STATE = BIT1 ;
         end

         //_________________________________________
         //

         BIT2 : begin

            TxD = tx_data[2] ;

            if(tx_en == 1'b1)
               NEXT_STATE = BIT3 ;
            else
               NEXT_STATE = BIT2 ;
         end

         //_________________________________________
         //

         BIT3 : begin

            TxD = tx_data[3] ;

            if(tx_en == 1'b1)
               NEXT_STATE = BIT4 ;
            else
               NEXT_STATE = BIT3 ;
         end

         //_________________________________________
         //

         BIT4 : begin

            TxD = tx_data[4] ;

            if(tx_en == 1'b1)
               NEXT_STATE = BIT5 ;
            else
               NEXT_STATE = BIT4 ;
         end

         //_________________________________________
         //

         BIT5 : begin

            TxD = tx_data[5] ;

            if(tx_en == 1'b1)
               NEXT_STATE = BIT6 ;
            else
               NEXT_STATE = BIT5 ;
         end

         //_________________________________________
         //

         BIT6 : begin

            TxD = tx_data[6] ;

            if(tx_en == 1'b1)
               NEXT_STATE = BIT7 ;
            else
               NEXT_STATE = BIT6 ;
         end

         //_________________________________________
         //

         BIT7 : begin

            TxD = tx_data[7] ;

            if(tx_en == 1'b1)
               NEXT_STATE = STOP ;
            else
               NEXT_STATE = BIT7 ;
         end


         //_________________________________________
         //

         STOP : begin

            TxD = 1'b1 ;                // assert STOP bit to 1'b1 as requested by RS232 protocol

            if(tx_en == 1'b1)
               NEXT_STATE = IDLE ;
            else
               NEXT_STATE = STOP ;
         end

      endcase

   end   // always


   // if not in IDLE assert the "busy" signal
   assign tx_busy = (STATE == IDLE) ? 1'b0 : 1'b1 ;


endmodule

