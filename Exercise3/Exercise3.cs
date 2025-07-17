using System;

namespace StringExercises
{
    class Exercise3
    {
        static void Main(string[] args)
        {
            Console.WriteLine("=== Exercise 3: String Concatenation ===");
            
            // Given word components - DO NOT MODIFY THESE
            string subject = "The cat";
            string verb = "jumped";
            string preposition = "over";
            string object1 = "the";
            string object2 = "fence";
            string adverb = "quickly";
            
            Console.WriteLine("Word Components:");
            Console.WriteLine($"Subject: '{subject}', Verb: '{verb}', Preposition: '{preposition}'");
            Console.WriteLine($"Articles/Objects: '{object1}', '{object2}', Adverb: '{adverb}'\n");
            
            // TODO: Method 1 - Using + operator
            // Requirements:
            // 1. Create a variable called 'sentence1'
            // 2. Build the sentence "The cat jumped over the fence quickly." using + operator
            // 3. Include proper spaces between words and a period at the end
            // 4. Display the result with label "Method 1 (+ operator): "
            
            // YOUR CODE HERE - START
            
            
            
            // YOUR CODE HERE - END
            
            // TODO: Method 2 - Using += operator
            // Requirements:
            // 5. Create a variable called 'sentence2' and initialize it with 'subject'
            // 6. Use += operator to add each word piece by piece
            // 7. Build the same sentence with proper spacing and period
            // 8. Display the result with label "Method 2 (+= operator): "
            
            // YOUR CODE HERE - START
            
            
            
            
            
            
            
            // YOUR CODE HERE - END
            
            // TODO: Method 3 - Using String.Concat()
            // Requirements:
            // 9. Create a variable called 'sentence3'
            // 10. Use String.Concat() method to combine all words with proper spacing
            // 11. Display the result with label "Method 3 (String.Concat): "
            
            // YOUR CODE HERE - START
            
            
            
            // YOUR CODE HERE - END
            
            // TODO: Method 4 - Using String.Join() with array
            // Requirements:
            // 12. Create a string array called 'words' containing all the word components
            // 13. Add the period to the last word (adverb) in the array
            // 14. Create a variable called 'sentence4' using String.Join with space separator
            // 15. Display the result with label "Method 4 (String.Join): "
            
            // YOUR CODE HERE - START
            
            
            
            
            // YOUR CODE HERE - END
            
            Console.WriteLine("\nPress any key to exit...");
            Console.ReadKey();
        }
    }
}
