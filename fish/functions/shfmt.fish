function shfmt
    for file in $argv
        if string match -q "*.fish" $file
            # Use fish_indent for Fish scripts
            fish_indent -w $file
        else
            # Use shfmt for bash/sh scripts
            docker run --rm -v $PWD:/work tmknom/shfmt $file
        end
    end
end
