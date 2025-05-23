for f in `find . -path './.*' -type f -not -path './.git/*' | sed 's|^./||'` ; do
    ln -f ~/$f ./$f 
done

