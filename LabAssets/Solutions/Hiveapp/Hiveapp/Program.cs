using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Hiveapp
{
    class Program
    {
        /// <summary> 
        /// returns monthname for the specified monthnumber         /// </summary> 
        /// <param name="monthnumber"></param> 
        /// <returns></returns> 
        static string monthnumbertoname(Int16 monthnumber)
        {
            System.Globalization.DateTimeFormatInfo mfi = new System.Globalization.DateTimeFormatInfo(); return mfi.GetMonthName(monthnumber).ToString();
        }

        static void Main(string[] args)
        {
            System.Globalization.DateTimeFormatInfo mfi = new System.Globalization.DateTimeFormatInfo();

            string line;
            // Read input in a loop 
            while ((line = Console.ReadLine()) != null)
            {
                // Parse the string, trimming line feeds 
                // and splitting fields at tabs                 line = line.TrimEnd('\n'); 
                string[] column = line.Split('\t');
                Int16 monthnumber = Convert.ToInt16(column[0]); string totalsales = column[1];
                Console.WriteLine("{0}\t{1}\t{2}", monthnumber, monthnumbertoname(monthnumber), totalsales);
            }
        }

    }
}
