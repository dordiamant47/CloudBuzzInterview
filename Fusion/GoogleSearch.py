# Import google search module
try:
    from googlesearch import search
except ImportError:
    print("No module named 'google' found")

# Request input from user
query = input("\nHello, Please enter your string for search in google: \n")

print("Top 5 Google Search results for your string:\n")
for j in search(query, tld="co.in", num=5, stop=5):
    print(j)
