input = [
    'files/algebra0-dict.txt',
    'files/analysisi-dict.txt',
    'files/analysisii-dict.txt',
    'files/at-dict.txt',
    'files/generic-dict.txt',
    'files/ladr-dict.txt',
    'files/napkin-dict.txt',
    'files/personal-dict.txt',
]
output = 'dictionary.txt'

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

# Print
file = open(output, 'w')
for word in words: 
    file.write(word + '\n')
file.close()
print('Wrote list to new file...')
