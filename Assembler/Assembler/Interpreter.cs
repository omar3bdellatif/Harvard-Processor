using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Assembler
{
    class Interpreter
    {
        public List<string> Binaries;
        Read fileRead;
        Write writeFile;

        public Interpreter()
        {
           // the memory size is 2048 Decimal - 7FF in Hexadecimal 
            Binaries = new List<string>(2048);
            for (int i = 0; i < 2048; i++)
                Binaries.Add("0000000000000000");
            writeFile = new Write();
        }

        public void Clear()
        {
            for (int i = 0; i < 2048; i++)
            {
                Binaries[i] = "0000000000000000";
            }
        }

//--------------------------------------------------------------------------------------------------------------

        public int Convert(string text, ref string msgError)
        {

            Clear();
            fileRead = new Read(text);
            Int16 address = 0;
            int i = 0;
            try
            {
                for (i = 0; i < fileRead.clearFile.Count; i++)//clearFile is a string list the consists of instrucstions
                {
                    string Code = "";
                    string menmonic = fileRead.clearFile[i];//takes each element in the list on it's own
                    menmonic = menmonic.Trim(); //Removes all leading and trailing white-space characters
                    if (menmonic == "")
                        continue;
                    List<string> datas = menmonic.Split(' ').ToList();
                    // Function split Returns An array whose elements contain the substrings in this instance that are
                    // delimited by one or more characters in separator.
                    //This line converts each instruction of a list on its own
                    if (datas[0] == "#")
                    {
                        //i++;
                        continue;
                    }

                    for (int j = 0; j < datas.Count; j++)
                    {
                        if (datas[j] == "" || datas[j]=="   ")
                            datas.RemoveAt(j);//Removes the element at specified index
                    }
                 /*   if (datas.Count == 1)
                    {
                        datas.AddRange(datas[1].Split(' ').ToList());
                        datas.RemoveAt(1);
                    }*/
                    if (datas.Count == 2)
                    {
                        if (datas[0] == ".org")
                        {
                            datas.AddRange(datas[1].Split(' ').ToList());
                            datas.RemoveAt(1);
                        }
                        else
                        {
                            datas.AddRange(datas[1].Split(',').ToList());
                            datas.RemoveAt(1);
                        }
                    }
                    else if (datas.Count == 3)
                    {
                        if (datas[0] == "or")
                        {
                            datas.RemoveAt(1);
                            datas.AddRange(datas[1].Split(',').ToList());
                            datas.RemoveAt(1);
                            //datas.RemoveAt(1);
                            //datas[1] = datas[1].Split(',')[0];
                        }
                        else
                        {
                            datas[1] = datas[1].Split(',')[0];
                        }
                    }

                    else if (datas.Count == 4 && datas[2] == ",")
                    {
                        datas.RemoveAt(2);
                    }
//-------------------------------------------------------------------------------------------------------------------------------------------------
                    string opcode = datas[0];

                    switch (opcode)
                    {
                        case "":
                            {
                                break;
                            }
                        /*case ".org":
                            {
                                 opcode[0]='.';
                                break;
                            }*/
                        case "nop":
                            {
                                Code = InstructionsOpcode.NOP;
                                if (datas.Count != 1)
                                {
                                    msgError = "Unexpected Operand";
                                    return i;
                                }
                                Code += "00000000000";
                                Binaries[address] = Code;
                                address++;
                                break;
                            }
                 //---------------------------
                        case "setc":
                            {
                                Code = InstructionsOpcode.setC;
                                if (datas.Count != 1)
                                {
                                    msgError = "Unexpected Operand";
                                    return i;
                                }
                                Code += "00000000000";
                                Binaries[address] = Code;
                                address++;
                                break;
                            }
                  //---------------------------
                        case "clrc":
                            {
                                Code = InstructionsOpcode.ClRC;
                                if (datas.Count != 1)
                                {
                                    msgError = "Unexpected Operand";
                                    return i;
                                }
                                Code += "00000000000";
                                Binaries[address] = Code;
                                address++;
                                break;
                            }
                  //---------------------------
                        case "ldd":
                            {
                                Code = InstructionsOpcode.LDD;
                                if (datas.Count != 3)
                                {
                                    msgError = "Unexpected number of operands";
                                    return i;
                                }

                                string reg = FetchOperand(datas[1]);
                                if (reg == "")
                                {
                                    msgError = "Unexpected operand: " + reg;
                                    return i;
                                }
                                else Code += reg;

                                Code += "00000000";

                                string EA = System.Convert.ToString(System.Convert.ToInt32(datas[2], 16), 2);
                                EA = EA.PadLeft(16, '0');
                                Binaries[address] = Code;
                                Binaries[address + 1] = EA;
                                address += 2;
                                break;
                            }
                 //---------------------------
                        case "std":
                            {
                                Code = InstructionsOpcode.STD;
                                if (datas.Count != 3)
                                {
                                    msgError = "Unexpected number of operands";
                                    return i;
                                }
                                Code += "000";
                                string reg = FetchOperand(datas[1]);
                                if (reg == "")
                                {
                                    msgError = "Unexpected operand: " + reg;
                                    return i;
                                }
                                
                                else Code += reg;

                                Code += "00000";

                                string EA = System.Convert.ToString(System.Convert.ToInt32(datas[2], 16), 2);
                                EA = EA.PadLeft(16, '0');
                                Binaries[address] = Code;
                                Binaries[address + 1] = EA;
                                address += 2;
                                break;
                            }
                     //---------------------------
                        case "ldm":
                            {
                                Code = InstructionsOpcode.LDM;
                                if (datas.Count != 3)
                                {
                                    msgError = "Unexpected number of operands";
                                    return i;
                                }

                                string reg = FetchOperand(datas[1]);
                                if (reg == "")
                                {
                                    msgError = "Unexpected operand: " + reg;
                                    return i;
                                }
                                else Code += reg;

                                Code += "00000000";
                             
                                /*if (oper2 >= 0)
                                    imm = imm.PadLeft(16, '0');
                                else
                                    imm = imm.PadLeft(16, '1');*/
                                string binaryval = System.Convert.ToString(System.Convert.ToInt32(datas[2], 16), 2);
                                binaryval = binaryval.PadLeft(16, '0');
                                Binaries[address] = Code;
                                Binaries[address + 1] = binaryval;
                                address += 2;
                                break;
                            }
                 //---------------------------
                        case "add":
                            {
                                Code = InstructionsOpcode.ADD;
                                if (datas.Count != 4)
                                {
                                    msgError = "Unexpected number of operands";
                                    return i;
                                }

                                string reg = FetchOperand(datas[3]);
                                if (reg == "")
                                {
                                    msgError = "Unexpected operand: " + reg;
                                    return i;
                                }
                                else Code += reg;
                                reg = FetchOperand(datas[1]);
                                if (reg == "")
                                {
                                    msgError = "Unexpected operand: " + reg;
                                    return i;
                                }
                                else Code += reg;
                                reg = FetchOperand(datas[2]);
                                if (reg == "")
                                {
                                    msgError = "Unexpected operand: " + reg;
                                    return i;
                                }
                                else Code += reg;
                                Code += "00";
                                Binaries[address] = Code;
                                address++;

                                break;
                            }
                        case "swap":
                            {
                                Code = InstructionsOpcode.SWAP;
                                if (datas.Count != 3)
                                {
                                    msgError = "Unexpected number of operands";
                                    return i;
                                }

                                string reg = FetchOperand(datas[2]);
                                if (reg == "")
                                {
                                    msgError = "Unexpected operand: " + reg;
                                    return i;
                                }
                                else Code += reg;
                                reg = FetchOperand(datas[1]);
                                if (reg == "")
                                {
                                    msgError = "Unexpected operand: " + reg;
                                    return i;
                                }
                                else Code += reg;
                                Code += "00000";
                                Binaries[address] = Code;
                                address++;

                                break;
                            }
                        case "iadd":
                            {
                                Code = InstructionsOpcode.IADD;
                                if (datas.Count != 4)
                                {
                                    msgError = "Unexpected number of operands";
                                    return i;
                                }

                                string reg = FetchOperand(datas[2]);
                                if (reg == "")
                                {
                                    msgError = "Unexpected operand: " + reg;
                                    return i;
                                }
                                else Code += reg;
                                reg = FetchOperand(datas[1]);
                                if (reg == "")
                                {
                                    msgError = "Unexpected operand: " + reg;
                                    return i;
                                }
                                else Code += reg;
                                Code += "00000";
                                string binaryval = System.Convert.ToString(System.Convert.ToInt32(datas[3], 16), 2); //getting imediate value
                                binaryval = binaryval.PadLeft(16, '0');
                                Binaries[address] = Code;
                                Binaries[address + 1] = binaryval;
                                address += 2;
                                break;
                            }
                        case "sub":
                            {
                                Code = InstructionsOpcode.SUB;
                                if (datas.Count != 4)
                                {
                                    msgError = "Unexpected number of operands";
                                    return i;
                                }

                                string reg = FetchOperand(datas[3]);
                                if (reg == "")
                                {
                                    msgError = "Unexpected operand: " + reg;
                                    return i;
                                }
                                else Code += reg;
                                reg = FetchOperand(datas[1]);
                                if (reg == "")
                                {
                                    msgError = "Unexpected operand: " + reg;
                                    return i;
                                }
                                else Code += reg;
                                reg = FetchOperand(datas[2]);
                                if (reg == "")
                                {
                                    msgError = "Unexpected operand: " + reg;
                                    return i;
                                }
                                else Code += reg;
                                Code += "00";
                                Binaries[address] = Code;
                                address++;

                                break;
                            }
                        case "and":
                            {
                                Code = InstructionsOpcode.AND;
                                if (datas.Count != 4)
                                {
                                    msgError = "Unexpected number of operands";
                                    return i;
                                }

                                string reg = FetchOperand(datas[3]);
                                if (reg == "")
                                {
                                    msgError = "Unexpected operand: " + reg;
                                    return i;
                                }
                                else Code += reg;
                                reg = FetchOperand(datas[1]);
                                if (reg == "")
                                {
                                    msgError = "Unexpected operand: " + reg;
                                    return i;
                                }
                                else Code += reg;
                                reg = FetchOperand(datas[2]);
                                if (reg == "")
                                {
                                    msgError = "Unexpected operand: " + reg;
                                    return i;
                                }
                                else Code += reg;
                                Code += "00";
                                Binaries[address] = Code;
                                address++;

                                break;
                            }

                        case "or":
                            {
                                Code = InstructionsOpcode.OR;
                                if (datas.Count != 4)
                                {
                                    msgError = "Unexpected number of operands";
                                    return i;
                                }

                                string reg = FetchOperand(datas[3]);
                                if (reg == "")
                                {
                                    msgError = "Unexpected operand: " + reg;
                                    return i;
                                }
                                else Code += reg;
                                reg = FetchOperand(datas[1]);
                                if (reg == "")
                                {
                                    msgError = "Unexpected operand: " + reg;
                                    return i;
                                }
                                else Code += reg;
                                reg = FetchOperand(datas[2]);
                                if (reg == "")
                                {
                                    msgError = "Unexpected operand: " + reg;
                                    return i;
                                }
                                else Code += reg;
                                Code += "00";
                                Binaries[address] = Code;
                                address++;

                                break;
                            }
                        case "not":
                            {
                                Code = InstructionsOpcode.NOT;
                                if (datas.Count != 2)
                                {
                                    msgError = "Unexpected number of operands";
                                    return i;
                                }

                                string reg = FetchOperand(datas[1]);
                                if (reg == "")
                                {
                                    msgError = "Unexpected operand: " + reg;
                                    return i;
                                }
                                else Code += reg;

                                Code += "00000000";

                                Binaries[address] = Code;
                                address++;

                                break;
                            }
                        case "inc":
                            {
                                Code = InstructionsOpcode.inc;
                                if (datas.Count != 2)
                                {
                                    msgError = "Unexpected number of operands";
                                    return i;
                                }

                                string reg = FetchOperand(datas[1]);
                                if (reg == "")
                                {
                                    msgError = "Unexpected operand: " + reg;
                                    return i;
                                }
                                else Code += reg;

                                Code += "00000000";

                                Binaries[address] = Code;
                                address++;

                                break;
                            }
                        case "dec":
                            {
                                Code = InstructionsOpcode.Dec;
                                if (datas.Count != 2)
                                {
                                    msgError = "Unexpected number of operands";
                                    return i;
                                }

                                string reg = FetchOperand(datas[1]);
                                if (reg == "")
                                {
                                    msgError = "Unexpected operand: " + reg;
                                    return i;
                                }
                                else Code += reg;

                                Code += "00000000";

                                Binaries[address] = Code;
                                address++;

                                break;
                            }   
                     
                        case "shr":
                            {
                                Code = InstructionsOpcode.SHR;
                                if (datas.Count != 3)
                                {
                                    msgError = "Unexpected number of operands";
                                    return i;
                                }

                                string reg = FetchOperand(datas[1]);
                                if (reg == "")
                                {
                                    msgError = "Unexpected operand: " + reg;
                                    return i;
                                }
                                else Code += reg;
                                Code += "00000000";
                                //string binaryval = System.Convert.ToString(System.Convert.ToInt32(datas[3], 16), 2); //getting imediate value
                                //binaryval = binaryval.PadLeft(16, '0');
                                //Binaries[address] = Code;
                                //Binaries[address + 1] = binaryval;
                               
                                string imm = System.Convert.ToString(System.Convert.ToInt32(datas[2], 16), 2);
                                //EA = EA.PadLeft(16, '0');
                                //string imm = System.Convert.ToString((byte)oper2, 2);
                                imm = imm.PadLeft(16, '0');
                                Binaries[address] = Code;
                                Binaries[address + 1] = imm;
                                address += 2;
                                break;
                            
                            }
                        case "shl":
                            {
                                Code = InstructionsOpcode.SHL;
                                if (datas.Count != 3)
                                {
                                    msgError = "Unexpected number of operands";
                                    return i;
                                }

                                string reg = FetchOperand(datas[1]);
                                if (reg == "")
                                {
                                    msgError = "Unexpected operand: " + reg;
                                    return i;
                                }
                                else Code += reg;
                                Code += "00000000";
                                //string binaryval = System.Convert.ToString(System.Convert.ToInt32(datas[3], 16), 2); //getting imediate value
                                //binaryval = binaryval.PadLeft(16, '0');
                                //Binaries[address] = Code;
                                //Binaries[address + 1] = binaryval;
                                string imm = System.Convert.ToString(System.Convert.ToInt32(datas[2], 16), 2);
                                
                                imm = imm.PadLeft(16, '0');
                                Binaries[address] = Code;
                                Binaries[address + 1] = imm;
                                address += 2;
                                break;
                            }
                        
                        case "push":
                            {
                                Code = InstructionsOpcode.PUSH;

                                if (datas.Count != 2)
                                {
                                    msgError = "Unexpected number of operands";
                                    return i;
                                }

                                string reg = FetchOperand(datas[1]);
                                if (reg == "")
                                {
                                    msgError = "Unexpected operand: " + reg;
                                    return i;
                                }
                                else Code += reg;

                                Code += "00000000";

                                Binaries[address] = Code;
                                address++;

                                break;
                            }
                        case "pop":
                            {
                                Code = InstructionsOpcode.POP;

                                if (datas.Count != 2)
                                {
                                    msgError = "Unexpected number of operands";
                                    return i;
                                }

                                string reg = FetchOperand(datas[1]);
                                if (reg == "")
                                {
                                    msgError = "Unexpected operand: " + reg;
                                    return i;
                                }
                                else Code += reg;
                                Code += "00000000";

                                Binaries[address] = Code;
                                address++;

                                break;
                            }
                        case "out":
                            {
                                Code = InstructionsOpcode.OUT;

                                if (datas.Count != 2)
                                {
                                    msgError = "Unexpected number of operands";
                                    return i;
                                }

                                string reg = FetchOperand(datas[1]);
                                if (reg == "")
                                {
                                    msgError = "Unexpected operand: " + reg;
                                    return i;
                                }
                                else Code += reg;

                                Code += "00000000";

                                Binaries[address] = Code;
                                address++;

                                break;
                            }
                        case "in":
                            {
                                Code = InstructionsOpcode.IN;

                                if (datas.Count != 2)
                                {
                                    msgError = "Unexpected number of operands";
                                    return i;
                                }

                                string reg = FetchOperand(datas[1]);
                                if (reg == "")
                                {
                                    msgError = "Unexpected operand: " + reg;
                                    return i;
                                }
                                else Code += reg;

                                Code += "00000000";

                                Binaries[address] = Code;
                                address++;

                                break;
                            }
                        case "jmp":
                            {
                                Code = InstructionsOpcode.JMP;
                                if (datas.Count != 2)
                                {
                                    msgError = "Unexpected number of operands";
                                    return i;
                                }

                                string reg = FetchOperand(datas[1]);
                                if (reg == "")
                                {
                                    msgError = "Unexpected operand: " + reg;
                                    return i;
                                }
                                else Code += reg;

                                Code += "00000000";
                                Binaries[address] = Code;
                                address++;

                                break;
                            }
                        case "jz":
                            {
                                Code = InstructionsOpcode.JZ;
                                if (datas.Count != 2)
                                {
                                    msgError = "Unexpected number of operands";
                                    return i;
                                }

                                string reg = FetchOperand(datas[1]);
                                if (reg == "")
                                {
                                    msgError = "Unexpected operand: " + reg;
                                    return i;
                                }
                                else Code += reg;
                                Code += "00000000";
                                Binaries[address] = Code;
                                address++;

                                break;
                            }
                        case "jn":
                            {
                                Code = InstructionsOpcode.JN;
                                if (datas.Count != 2)
                                {
                                    msgError = "Unexpected number of operands";
                                    return i;
                                }

                                string reg = FetchOperand(datas[1]);
                                if (reg == "")
                                {
                                    msgError = "Unexpected operand: " + reg;
                                    return i;
                                }
                                else Code += reg;
                                Code += "00000000";
                                Binaries[address] = Code;
                                address++;

                                break;
                            }
                        case "jc":
                            {
                                Code = InstructionsOpcode.JC;
                                if (datas.Count != 2)
                                {
                                    msgError = "Unexpected number of operands";
                                    return i;
                                }

                                string reg = FetchOperand(datas[1]);
                                if (reg == "")
                                {
                                    msgError = "Unexpected operand: " + reg;
                                    return i;
                                }
                                else Code += reg;
                                Code += "00000000";
                                Binaries[address] = Code;
                                address++;

                                break;
                            }
                        case "call":
                            {
                                Code = InstructionsOpcode.CALL;
                                if (datas.Count != 2)
                                {
                                    msgError = "Unexpected number of operands";
                                    return i;
                                }

                                string reg = FetchOperand(datas[1]);
                                if (reg == "")
                                {
                                    msgError = "Unexpected operand: " + reg;
                                    return i;
                                }
                                else Code += reg;
                                Code += "00000000";
                                Binaries[address] = Code;
                                address++;

                                break;
                            }
                        case "ret":
                            {
                                Code = InstructionsOpcode.RET;
                                if (datas.Count != 1)
                                {
                                    msgError = "Unexpected number of operands";
                                    return i;
                                }
                                Code += "00000000000";

                                Binaries[address] = Code;
                                address++;

                                break;
                            }
                        case "rti":
                            {
                                Code = InstructionsOpcode.RTI;
                                if (datas.Count != 1)
                                {
                                    msgError = "Unexpected number of operands";
                                    return i;
                                }

                                Code += "00000000000";

                                Binaries[address] = Code;
                                address++;

                                break;
                            }
                        default:
                            {
                                string binaryval;
                                String Num = "";
                               
                                if (opcode.Substring(0).Equals(".org")==true && datas.Count == 2)
                                {
                                    //int add = System.Convert.string(opcode.Substring(1));
                                  Int16 add   = System.Convert.ToInt16(datas[1], 16);
                                    if (add > 2048)
                                    {
                                        msgError = "You exceeded the limit of the memory.";
                                        return i;
                                    }
                                    else
                                    {
                                        address = add;
                                        //string val = fileRead.clearFile[i++];
                                        //Binaries[address] = val;
                                        break;
                                    }
                                }
                                
                                else
                                {
                                    Num = opcode;
                                    binaryval = System.Convert.ToString(System.Convert.ToInt32(Num, 16), 2);


                                    //Code = System.Convert.ToString(Num, 2);
                                    // string binaryval = System.Convert.ToString(Num, 2);
                                    binaryval = binaryval.PadLeft(16, '0');
                                    /* if (Num >= 0)
                                         Code = Code.PadLeft(16, '0');
                                     else*/
                                    //Code = binaryval.PadLeft(16, '0');
                                    Binaries[address] = binaryval;
                                    address++;
                                    break;
                                }

                                msgError = "Unknown Instruction " + datas[0];
                                return i;
                                    
                    }
                            }
                    if (address > 2048)
                    {
                        msgError = "you exceed the limit of the memory. The memory is 1000 bytes only";
                        return i;
                    }
                }

                int index = text.LastIndexOf('.');
                string path = text.Substring(0, index + 1);
                path += "mem";
                writeFile.WriteFile(path, Binaries);
                return -1;
            }
            catch (Exception exc)
            {
                return i;
            }

        }


        public string FetchOperand(string s)
        {
            if (s == "r0")
                return "000";
            else if (s == "r1")
                return "001";
            else if (s == "r2")
                return "010";
            else if (s == "r3")
                return "011";
            else if (s == "r4")
                return "100";
            else if (s == "r5")
                return "101";
            else if (s == "r6")
                return "110";
            else if (s == "r7")
                return "111";
            else return "";
        }
      
    }
}
