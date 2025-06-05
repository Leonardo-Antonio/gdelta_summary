# gdelta_summary
gdelta_summary A script that compares two Git versions and outputs a formatted summary showing the status (new, modified) and line ranges of changed files, providing a clear overview of code changes between versions.

# Install 
```bash
wget https://github.com/Leonardo-Antonio/gdelta_summary/archive/refs/tags/v1.0.0.zip -O gdelta_summary.zip
sudo bash -c '
mkdir -p /usr/share/gdelta_summary && \
unzip gdelta_summary.zip -d /usr/share/gdelta_summary && \
mv /usr/share/gdelta_summary/gdelta_summary-1.0.0/gdelta_summary.sh /usr/bin && \
chmod +x /usr/bin/gdelta_summary.sh && \
rm gdelta_summary.zip
'
```

# Usage
```bash
# sample
/usr/bin/gdelta_summary.sh <version1> <version2>

# using alias
gdelta_summary <version1> <version2>
```

# Alias
```bash
echo "alias gdelta_summary='/usr/bin/gdelta_summary.sh'" >> ~/.zshrc && source ~/.zshrc

or 

echo "alias gdelta_summary='/usr/bin/gdelta_summary.sh'" >> ~/.bashrc && source ~/.bashrc
```

# Uninstall
```bash
sudo rm -rf /usr/bin/gdelta_summary.sh /usr/share/gdelta_summary 
```
