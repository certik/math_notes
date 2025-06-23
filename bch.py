from sympy import symbols, Matrix, factorial, prod, eye, Mul, expand

def bch_term(n, A_symbol='A', B_symbol='B'):
    """
    Compute the nth order term z_n in the Baker-Campbell-Hausdorff series for log(e^A e^B).
    
    Parameters:
    - n: Integer, the order of the term.
    - A_symbol: String, symbol for the first variable (default 'A').
    - B_symbol: String, symbol for the second variable (default 'B').
    
    Returns:
    - z_n: Symbolic expression representing the nth term.
    """
    # Define symbolic variables s1, s2, ..., sn
    s = symbols(f's1:{n+1}')  # Creates s1, s2, ..., sn
    
    # Define matrix F: F[i,j] = 1/(j-i)! if j >= i, else 0
    F = Matrix(n+1, n+1, lambda i, j: 1/factorial(j-i) if j >= i else 0)
    
    # Define matrix G: G[i,j] = 1/(j-i)! * Product(s_k for k from i to j-1) if j > i,
    #                  G[i,i] = 1, G[i,j] = 0 if j < i
    G = Matrix(n+1, n+1, lambda i, j: (
        1/factorial(j-i) * prod(s[k] for k in range(i, j)) if j > i else
        (1 if i == j else 0)
    ))
    
    # Compute F * G
    FG = F * G
    
    # Identity matrix
    I = eye(n+1)
    
    # Compute FG - I
    FGm1 = FG - I
    
    # Compute log(FG) using series: sum_{q=1}^n (-1)^{q+1}/q * (FG - I)^q
    logFG = sum((-1)**(q+1)/q * FGm1**q for q in range(1, n+1))
    
    # Extract the polynomial p at position [0, n] (SymPy uses 0-based indexing)
    p = expand(logFG[0, n])
    
    # Define symbols for A and B
    A, B = symbols(A_symbol), symbols(B_symbol)
    
    # Initialize z_n
    z_n = 0
    
    # Process each term in the polynomial
    for monomial, coeff in p.as_coefficients_dict().items():
        if monomial == 1:  # Constant term means all positions are A
            word = A**n
        else:
            # Find indices where s_i appears (adjusting for 0-based indexing)
            indices = {i for i in range(n) if s[i] in monomial.free_symbols}
            # Construct the word: B at positions where s_i appears, A elsewhere
            word = Mul(*[B if j in indices else A for j in range(n)])
        z_n += coeff * word
    
    return z_n

# Example usage
if __name__ == "__main__":
    # Test for n=1
    print("z_1 =", bch_term(1))  # Expected: A + B
    # Test for n=2
    print("z_2 =", bch_term(2))  # Expected: (1/2)*A*B - (1/2)*B*A
    # Test for n=3
    print("z_3 =", bch_term(3))  # Matches article's example
