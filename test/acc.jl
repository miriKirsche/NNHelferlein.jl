# funs for test of acc-funs:
#

function test_peak_finder()

    t = [0, 0,   0,   0, 0,   1,   0,   0,   0, 0, 0, 1]
    y = [0, 0.1, 0.1, 0, 0.8, 0,   0,   0, 0.9, 0, 0, 0]

    f1 = peak_finder_acc(y, t, verbose=3)  # != 2/3
    gm = peak_finder_acc(y, t, verbose=1, ret=:g_mean)  # ≈ 0.7071
    iou = peak_finder_acc(y, t, verbose=1, ret=:iou)  # 
    return f1 ≈ 2/3 && gm ≈ 0.7071067811865 && iou ≈ 0.5
end



function test_peak_finder_acc()

    t = [0, 0,   0,   0, 0,   1,   0,   0,   0, 0, 0, 1]
    y = [0, 0.1, 0.1, 0, 0.8, 0,   0,   0, 0.9, 0, 0, 0]
    d = [(y,t), (y,t)]

    mdl(x) = x
    f1 = peak_finder_acc(mdl, data=d)
    return f1 ≈ 2/3 
end



function test_hamming()

        p = [0  0  0  0  0
             4  4  3  4  5
             2  2  2  2  5
             1  3  1  3  3
             0  0  0  0  0]
        t = [0  0  0  0  0
             4  4  5  3  4
             3  1  2  4  4
             2  5  5  4  2
             0  0  0  0  0]

        acc = hamming_dist(p,t)
        hd = hamming_acc(p,t)

       return isapprox(acc, 0.6, atol=0.05) && isapprox(hd, 0.77, atol=0.05)
end


function test_hamming_acc()

        p = [0  0  0  0  0
             4  4  3  4  5
             2  2  2  2  5
             1  3  1  3  3
             0  0  0  0  0]
        t = [0  0  0  0  0
             4  4  5  3  4
             3  1  2  4  4
             2  5  5  4  2
             0  0  0  0  0]

        d = [(p,t), (p,t)]
        mdl(x) = x

        acc = hamming_acc(mdl, data=d)
        
       return isapprox(acc, 0.76, atol=0.1)
end



function test_hamming_vocab()
    tok = WordTokenizer(["I love Julia",
                         "Peter loves Python",
                         "We all marvel Geoff"])
    l = tok(["I love Julia", "Peter loves Python", "We all marvel Geoff"],
            add_ctls=true)

     h1 = hamming_dist([1, 7, 9, 8, 2], [1, 5, 9, 8, 2], vocab=tok)  # =! 1

     return h1 == 1
end


function test_hamming_length()
    tok = WordTokenizer(["I love Julia",
                         "Peter loves Python",
                         "We all marvel Geoff"])
    l = tok(["I love Julia", "Peter loves Python", "We all marvel Geoff"],
            add_ctls=true)
     p = [1, 7, 9, 8, 2]
     t = [1, 7, 9, 2]
     h1 = hamming_dist(p, t, vocab=tok)  # =! 1
     h2 = hamming_dist(t, p, vocab=tok)  # =! 2

     return h1 == 1 && h2 == 2
end