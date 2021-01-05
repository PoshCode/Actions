# This requires vercel ncc:
#    npm i -g @vercel/ncc
foreach ($source in Get-ChildItem $PSScriptRoot/*/src/*.js) {
    ncc build $source.FullName --out $source.Directory.Parent.FullName --minify --license licenses.txt
}