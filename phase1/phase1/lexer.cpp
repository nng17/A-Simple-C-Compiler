/* Nathan Ng
 * COEN 175
 * Project 1
 * Lexical.cpp
 */

#include <iostream>
#include <string>
#include <cctype>
#include <ctype.h>

using namespace std;

int main(int argc, char* argv[]){
    char c;
    //character to look ahead;
    char d;
    string s;
    int i;
    int flag;
    
    //string array for keywords
    const string keywords[] = {"auto", "break", "case", "char", "const", "continue", "default", "do", "double", "else", "enum", "extern", "float", "for", "goto", "if", "int", "long", "register", "return", "short", "signed", "sizeof", "static", "struct", "switch", "typedef", "union", "unsigned", "void", "volatile", "while"};
    
    c = cin.get();
    while(!cin.eof()) {
        //first checks for any white space, such as from space, or tab, or new line
        //skip white space
        if(isspace(c))
        {
            c = cin.get();
            continue;
        }
        
        
        //handle numbers, uses the cctype isdigits()
        else if(isdigit(c))
        {
            s.clear();
            do {
                s+=c;
                c = cin.get();
            } while(isdigit(c));
            cout << "number:" << s << endl;
        }
        
        
        //handles identifiers & keywords, uses cctype isalpha()
        else if(c == '_' || (isalpha(c)))
        {
            //flag to see if it is an identifier or a keyword
            flag = 0;
            s.clear();
            // do while loop to traverse and add character to string while c is an underscore, a letter or a number
            do{
                s+=c;
                c = cin.get();
            }while(c == '_' || isalpha(c) || isdigit(c));
            
            //for loop to check the current string with the array of keywords
            //if it is a match, set flag to 1 to indicate keyword and print out keyword
            for(i = 0; i < 32; i ++)
            {
                if(s.compare(keywords[i]) == 0)
                {
                    cout << "keyword:" << s << endl;
                    flag = 1;
                }
            }
            //case where there is no keyword but an identifier
            if(flag == 0)
                cout << "identifier:" << s << endl;
        }
        
        //handles strings
        //first check if the character is a " indiciating the start of a string
        else if(c == '"')
        {
            s.clear();
            //forever loop that keeps getting a new character and puts it into the string as long as it does not reach the last " mark.
            while(1)
            {
                s+=c;
                c = cin.get();
                //if statement to check for nested "
                //first checks to see if a " is found
                //then sees if there is an escape character
                if(c == '"' && s[s.length()-1] == '\\')
                {
                    continue;
                }
                //case where you hit the last " in the string
                else if(c == '"')
                {
                    s+=c;
                    break;
                }
            }
            cout << "string:" << s << endl;
            c = cin.get();
        }
        
        //handles comments
        //first check to see if the starting character is a /
        else if(c == '/')
        {
            s.clear();
            s+=c;
            c = cin.get();
            //grab the next character
            //check if it is actually a comment by looking for a *
            //if it is a comment, keep going and add characters into the string until you hit another /
            //when it hits another /, check for the character before to make sure it is a * indicating the end of the comment
            if(c == '*')
            {
                do {
                    s+=c;
                    c = cin.get();
                } while(!(c == '/' && s[s.length()-1] == '*'));
            }
            //if not comment, put back and then mark as operator
            else
            {
                c = d;
                cout << "operator:/" << endl;
            }
            c = cin.get();
        }
        
        //handles operators
        //first check for single operator
        //if it is a single operator, print
        else if(ispunct(c))
        {
            s.clear();
            if(c == '*'|| c == '/' || c == '%' || c == '.' || c == '(' || c == ')' || c == '[' || c == ']' || c == '{' || c == '}' || c == ';' || c == ':' || c == ',')
            {
                s+=c;
                c = cin.get();
                cout << "operator:" << s << endl;
                s.clear();
            }
            
            //case where "|" doesnt count but "||" counts
            else if(c == '|')
            {
                //see what the next character is
                d = cin.get();
                if(d == '|')
                {
                    cout << "operator:||" << endl;
                    c = cin.get();
                }
                else
                {
                    c=d;
                }
            }
            
            //case for double operators.
            //if it finds one of the special double operators, uses a new char to check the next for the next character
            else if(c == '=')
            {
                //see what the next character is
                d = cin.get();
                if(d == '=')
                {
                    cout << "operator:==" << endl;
                    c = cin.get();
                }
                //if not the double operator case
                else
                {
                    c=d;
                    cout << "operator:=" << endl;
                }
            }
            else if(c == '&')
            {
                //see what the next character is
                d = cin.get();
                if(d == '&')
                {
                    cout << "operator:&&" << endl;
                    c = cin.get();
                }
                //if not the operator case
                else
                {
                    c = d;
                    cout << "operator:&" << endl;
                }
            }
            else if(c == '!')
            {
                //see what the next character is
                d = cin.get();
                if(d == '=')
                {
                    cout << "operator:!=" << endl;
                    c = cin.get();
                }
                //if not the operator case
                else
                {
                    c = d;
                    cout << "operator:!" << endl;
                }
            }
            else if(c == '<')
            {
                //see what the next character is
                d = cin.get();
                if(d == '=')
                {
                    cout << "operator:<=" << endl;
                    c = cin.get();
                }
                //if not the operator case
                else
                {
                    c = d;
                    cout << "operator:<" << endl;
                }
            }
            else if(c == '>')
            {
                //see what the next character is
                d = cin.get();
                if(d == '=')
                {
                    cout << "operator:>=" << endl;
                    c = cin.get();
                }
                //if not the operator case
                else
                {
                    c = d;
                    cout << "operator:>" << endl;
                }
            }
            else if(c == '+')
            {
                //see what the next character is
                d = cin.get();
                if(d == '+')
                {
                    cout << "operator:++" << endl;
                    c = cin.get();
                }
                //if not the operator case
                else
                {
                    c = d;
                    cout << "operator:+" << endl;
                }
            }
            //case for - where there are 3 possible combinations
            else if(c == '-')
            {
                //see what the next character is
                d = cin.get();
                if(d == '-')
                {
                    cout << "operator:--" << endl;
                    c = cin.get();
                }
                else if(d == '>')
                {
                    cout << "operator:->" << endl;
                    c = cin.get();
                }
                //if not any of the double operators
                else
                {
                    c = d;
                    cout << "operator:-" << endl;
                }
            }
            //all other illegal operators
            else
            {
                c = cin.get();
            }
        }
    }
    return 0;
}

