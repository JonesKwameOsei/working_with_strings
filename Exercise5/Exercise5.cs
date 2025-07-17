using System;

namespace StringExercises
{
    class Exercise5
    {
        static void Main(string[] args)
        {
            Console.WriteLine("=== Exercise 5: String Methods ===");
            
            // Given messy user input - DO NOT MODIFY THESE
            string userEmail = "  JOHN.SMITH@GMAIL.COM  ";
            string userComment = "This product is AMAZING!!! I love it so much!!!";
            string userPhone = "(555) 123-4567 ext. 890";
            string productReview = "  The wireless headphones are great, but the WIRELESS connection sometimes drops. Overall, wireless technology is improving.  ";
            
            Console.WriteLine("=== Original Messy Data ===");
            Console.WriteLine($"Email: '{userEmail}'");
            Console.WriteLine($"Comment: '{userComment}'");
            Console.WriteLine($"Phone: '{userPhone}'");
            Console.WriteLine($"Review: '{productReview}'");
            
            Console.WriteLine("\n=== Cleaning Data with String Methods ===");
            
            // TODO: TRIM - Remove whitespace and convert to lowercase
            // Requirements:
            // 1. Create 'cleanEmail' by trimming userEmail and converting to lowercase
            // 2. Create 'cleanReview' by trimming productReview
            // 3. Display both cleaned strings with appropriate labels
            
            // YOUR CODE HERE - START
            
            
            
            
            // YOUR CODE HERE - END
            
            // TODO: REPLACE - Format phone number
            // Requirements:
            // 4. Create 'formattedPhone' by removing: "(", ")", "-", spaces
            // 5. Also replace "ext." with "x"
            // 6. Chain multiple Replace() calls
            // 7. Display the formatted phone with label
            
            // YOUR CODE HERE - START
            
            
            
            
            
            // YOUR CODE HERE - END
            
            // TODO: REPLACE - Tone down comment
            // Requirements:
            // 8. Create 'censoredComment' by replacing:
            //    - "AMAZING" with "great"
            //    - "!!!" with "!"
            //    - "so much" with "very much"
            // 9. Display the toned down comment with label
            
            // YOUR CODE HERE - START
            
            
            
            
            
            // YOUR CODE HERE - END
            
            // TODO: REPLACE - Case-insensitive replacement
            // Requirements:
            // 10. Create 'updatedReview' by replacing all instances of "wireless" with "Bluetooth"
            // 11. Use StringComparison.OrdinalIgnoreCase for case-insensitive replacement
            // 12. Also trim the result
            // 13. Display the updated review with label
            
            // YOUR CODE HERE - START
            
            
            
            
            // YOUR CODE HERE - END
            
            Console.WriteLine("\n=== Search Operations ===");
            
            // TODO: CONTAINS - Check if string contains substring
            // Requirements:
            // 14. Create 'containsGreat' boolean to check if cleanReview contains "great"
            // 15. Display the result with format "Review contains 'great': True/False"
            
            // YOUR CODE HERE - START
            
            
            // YOUR CODE HERE - END
            
            // TODO: INDEXOF - Find position and extract parts
            // Requirements:
            // 16. Create 'atPosition' to find position of "@" in cleanEmail
            // 17. Display the position with format "Position of '@' in email: X"
            // 18. IF atPosition > 0, extract username and domain using Substring
            // 19. Display username and domain with format "Username: 'X', Domain: 'Y'"
            
            // YOUR CODE HERE - START
            
            
            
            
            
            
            
            // YOUR CODE HERE - END
            
            // TODO: STARTSWITH and ENDSWITH
            // Requirements:
            // 20. Create 'isGmail' boolean to check if cleanEmail ends with "@gmail.com"
            // 21. Create 'startsWithJohn' boolean to check if cleanEmail starts with "john"
            // 22. Display both results with appropriate labels
            
            // YOUR CODE HERE - START
            
            
            
            
            // YOUR CODE HERE - END
            
            // TODO: LASTINDEXOF - Find first and last occurrence
            // Requirements:
            // 23. Create a test string: "The word 'test' appears in this test string for testing purposes"
            // 24. Find first occurrence of "test" using IndexOf
            // 25. Find last occurrence of "test" using LastIndexOf
            // 26. Display both positions with appropriate labels
            
            // YOUR CODE HERE - START
            
            
            
            
            
            // YOUR CODE HERE - END
            
            Console.WriteLine("\n=== Final Processed Data ===");
            // TODO: Display all cleaned data
            // Requirements:
            // 27. Display all the cleaned variables with appropriate labels
            
            // YOUR CODE HERE - START
            
            
            
            
            
            // YOUR CODE HERE - END
            
            Console.WriteLine("\nPress any key to exit...");
            Console.ReadKey();
        }
    }
}
