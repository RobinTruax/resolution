# Dependencies
from titlecase import titlecase

# File Configuration
input = [
    'interim/napkin-dict-1.txt',
    'interim/napkin-dict-2.txt',
    'interim/napkin-dict-3.txt',
    'interim/napkin-dict-4.txt',
]
output = 'files/napkin-dict.txt'

# Make words unique
def unique(lst): 
    unique_lst = []
    for l in lst: 
        if l not in unique_lst: 
            unique_lst.append(l)
    return unique_lst

# Get list of words
words = []
for name in input: 
    file = open(name, 'r')
    lines = [i[:-1] for i in file.readlines()]
    file.close()
    words += lines
print('Obtained list of words from input files...')

# Clean up
words = sorted(unique(words))
print('Cleaned list of words...')

# Add case duplicates
new_words = []
for word in words: 
    new_words.append(word)
    if word[0].islower(): 
        new_words.append(word[0].upper() + word[1:])
print('Added case duplicates...')

# Clean up again
new_words = unique(new_words)
print('Cleaned list of words again...')

# Print
file = open(output, 'w')
for word in new_words: 
    file.write(word + '\n')
file.close()
print('Wrote list to new file...')
