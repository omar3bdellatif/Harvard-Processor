using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Assembler
{
    static public class InstructionsOpcode
    {
        static public string NOP
        {
            get
           {
                return "00000";
            }
        }
        static public string OUT
        {
            get
            {
                return "00110";
            }
        }
        static public string IN
        {
            get
            {
                return "00111";
            }
        }
        static public string setC
        {
            get
            {
                return "00001";
            }
        }
        static public string ClRC
        {
            get
            {
                return "00010";
            }
        }
        static public string inc
        {
            get
            {
                return "00100";
            }
        }
        static public string Dec
        {
            get
            {
                return "00101";
            }
        }
        static public string NOT
        {
            get
            {
                return "00011";
            }
        }
        static public string ADD
        {
            get
            {
                return "01001";
            }
        }
        static public string SWAP
        {
            get
            {
                return "01000";
            }
        }
        static public string IADD
        {
            get
            {
                return "01010";
            }
        }
        static public string SUB
        {
            get
            {
                return "01011";
            }
        }
        
        static public string AND
        {
            get
            {
                return "01100";
            }
        }
        static public string OR
        {
            get
            {
                return "01101";
            }
        }
        static public string SHL
        {
            get
            {
                return "01110";
            }
        }
        static public string SHR
        {
            get
            {
                return "01111";
            }
        }
       
        static public string LDD
        {
            get
            {
                return "10011";
            }
        }
        static public string STD
        {
            get
            {
                return "10100";
            }
        }
        static public string POP
        {
            get
            {
                return "10001";
            }
        }
        static public string PUSH
        {
            get
            {
                return "10000";
            }
        }
        static public string LDM
        {
            get
            {
                return "10010";
            }
        }
        static public string RET
        {
            get
            {
                return "11010";
            }
        }
        static public string JZ
        {
            get
            {
                return "10101";
            }
        }
        static public string JN
        {
            get
            {
                return "10110";
            }
        }
        static public string JC
        {
            get
            {
                return "10111";
            }
        }
        static public string JMP
        {
            get
            {
                return "11000";
            }
        }
        static public string CALL
        {
            get
            {
                return "11001";
            }
        }
        static public string RTI
        {
            get
            {
                return "11011";
            }
        }
       
        
    }
}
