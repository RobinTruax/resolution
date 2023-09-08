# Dependencies
from PyPDF2 import PdfReader
from re import split, sub
from copy import deepcopy

# File Configuration
input = 'chapter0.pdf'
output = 'algebra0-dict'
# Scraping Configuration
freq_threshold = [5, 7, 10, 10, 10]
length_threshold = [6, 10, 15, 20, 20]

# Report length of PDF for user verification
reader = PdfReader(input)
print('Submitted PDF has', len(reader.pages), 'pages.')

# Create dictionary of all words in PDF
pages = reader.pages
words = [{} for i in freq_threshold]
# Iterate through pages
page_num = 0
for page in pages: 
    # Report page number
    page_num += 1
    print('Scanning page', page_num, '...')
    # Clean & split text
    text = sub(r"[0-9][0-9]", " ", page.extract_text())
    text = sub(r"[^a-zA-Z0-9\-\' ]+", "", text)
    split_text = [i for i in split('\s', text) if i != '']
    # Drop all quotes
    for i in range(len(split_text)):
        for j in range(len(freq_threshold)): 
            if i + j < len(split_text): 
                word = ' '.join([split_text[i+k] for k in range(j+1)])
                if word in words[j]: 
                    words[j][word] += 1
                else: 
                    words[j][word] = 1
print('A total of', [len(words_list) for words_list in words], 'word objects were found.')

# Trim case duplicates
print('Trimming case duplicates...')
words_no_case = deepcopy(words)
for i in range(len(words)):
    for word in words[i]: 
        if not word.islower(): 
            if word.lower() in words[i]: 
                words_no_case[i][word.lower()] += words_no_case[i].pop(word)
print('After case-duplicate removal, a total of', [len(words_list) for words_list in words_no_case], 'word objects remain.')

# Trim rare words
print('Trimming rare words...')
words_no_rare = deepcopy(words_no_case)
for i in range(len(words_no_case)):
    for word in words_no_case[i]:
        if words_no_case[i][word] < freq_threshold[i]: 
            words_no_rare[i].pop(word)
print('After rare word removal, a total of', [len(words_list) for words_list in words_no_rare], 'word objects remain.')

# Trim short words
words_no_short = deepcopy(words_no_rare)
for i in range(len(words_no_rare)):
    for word in words_no_rare[i]: 
        if len(word) < length_threshold[i] or len(word) > 20: 
            words_no_short[i].pop(word)
print('After short word removal, a total of', [len(words_list) for words_list in words_no_short], 'word objects remain.')

# Sort the dictionary
words_sorted = [sorted(words_list) for words_list in words_no_short]

for i in range(len(words_sorted)):
    print('Writing to file', i+1, '...')
    filename = output + '-' + str(i+1) + '.txt'
    file = open(filename, 'w')
    for word in words_sorted[i]: 
        file.write(word + '\n')
    file.close()
