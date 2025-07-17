using System;

namespace StringExercises
{
    class Exercise4
    {
        static void Main(string[] args)
        {
            Console.WriteLine("=== Exercise 4: String Interpolation ===");
            
            // Given product information - DO NOT MODIFY THESE
            string productName = "Wireless Headphones";
            string brand = "TechSound";
            decimal price = 89.99m;
            int stockQuantity = 25;
            double rating = 4.5;
            bool isOnSale = true;
            decimal discountPercent = 15.0m;
            
            Console.WriteLine("=== Product Catalog ===");
            
            // TODO: Basic string interpolation
            // Requirements:
            // 1. Use string interpolation to display "Product: [productName]"
            // 2. Use string interpolation to display "Brand: [brand]"
            
            // YOUR CODE HERE - START
            
            
            // YOUR CODE HERE - END
            
            // TODO: Formatting numbers with string interpolation
            // Requirements:
            // 3. Display price with 2 decimal places using format "Price: $89.99"
            // 4. Display stock with format "Stock: 25 units available"
            // 5. Display rating with 1 decimal place using format "Rating: 4.5/5.0 stars"
            
            // YOUR CODE HERE - START
            
            
            
            // YOUR CODE HERE - END
            
            // TODO: Conditional expressions in interpolation
            // Requirements:
            // 6. Display stock status: "In Stock" if stockQuantity > 0, otherwise "Out of Stock"
            // 7. Display sale status: "ON SALE!" if isOnSale is true, otherwise "Regular Price"
            
            // YOUR CODE HERE - START
            
            
            // YOUR CODE HERE - END
            
            // TODO: Complex expressions in interpolation
            // Requirements:
            // 8. IF the product is on sale, calculate and display the sale price
            // 9. Use this format: "Sale Price: $XX.XX (Save 15% - $XX.XX off!)"
            // 10. Calculate: salePrice = price - (price * discountPercent / 100)
            // 11. Calculate savings: price - salePrice
            
            // YOUR CODE HERE - START
            
            
            
            
            
            
            // YOUR CODE HERE - END
            
            // TODO: Multi-line string interpolation
            // Requirements:
            // 12. Create a variable called 'productSummary' using verbatim string (@"")
            // 13. Include all product information in a formatted summary
            // 14. Use string interpolation within the verbatim string
            // 15. Display the productSummary
            
            // YOUR CODE HERE - START
            
            
            
            
            
            
            
            
            
            
            
            
            // YOUR CODE HERE - END
            
            Console.WriteLine("\nPress any key to exit...");
            Console.ReadKey();
        }
    }
}
