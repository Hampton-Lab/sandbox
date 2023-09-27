# sandbox (practice github, wget, & google drive)

### Getting wget onto your computer

Before running ANY scripts from this repo, perform these tasks in the EXACT order they are described. 

A few things to ask before you start with this data-code workflow.
1. Do you have wget installed on your machine? (To check, open terminal, type wget, hit enter)
2. If you do, go to next section!
3. If you do not, follow the steps to download wget for a <a href="https://www.maketecheasier.com/install-wget-mac/">MAC</a>, for a <a href="https://www.tomshardware.com/how-to/use-wget-download-files-command-line">Windows/PC</a>. If you have a linux, go to terminal and type <i> sudo app install wget </i>.

### Cloning GitHub Repos and Downloding data form Google Drive
1. Open R studio
2. Click the <i> Terminal </i> tab in the bottom left console
3. Run - <i>git clone https://github.com/Hampton-Lab/sandbox</i>
4. Run - wget --no-check-certificate 'https://docs.google.com/uc?export=download&id=1gv8ndlHwRC2GFm8jjnA5CIerI5DyLXBV' -O Iceland.csv
5. Congrats - you have now downloaded the most recent code and the most recent data that the code utilizes
