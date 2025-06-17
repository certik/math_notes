import numpy as np
from scipy.linalg import expm

def compute_equivalent_rotation(theta1, theta2, theta3):
    """
    Computes the equivalent rotation angle theta and axis n for a sequence of
    three rotations around the x, y, and z axes.

    The function implements the identity:
    e^{-i(theta1/2)sigma1} * e^{-i(theta2/2)sigma2} * e^{-i(theta3/2)sigma3} = e^{-i(theta/2)(n.sigma)}

    Args:
        theta1 (float): The rotation angle around the x-axis (in radians).
        theta2 (float): The rotation angle around the y-axis (in radians).
        theta3 (float): The rotation angle around the z-axis (in radians).

    Returns:
        tuple: A tuple containing:
            - theta (float): The equivalent single rotation angle (in radians).
            - n (np.ndarray): The 3D unit vector representing the axis of rotation.
    """
    # Define the Pauli matrices
    sigma1 = np.array([[0, 1], [1, 0]], dtype=complex)
    sigma2 = np.array([[0, -1j], [1j, 0]], dtype=complex)
    sigma3 = np.array([[1, 0], [0, -1]], dtype=complex)
    identity = np.identity(2, dtype=complex)

    # --- Step 1: Construct the LHS matrix U ---
    # Construct the individual rotation operators from the LHS
    U1 = expm(-0.5j * theta1 * sigma1)
    U2 = expm(-0.5j * theta2 * sigma2)
    U3 = expm(-0.5j * theta3 * sigma3)

    # Multiply them to get the final unitary matrix U
    U = U1 @ U2 @ U3

    # --- Step 2: Extract theta from U ---
    # From the identity U = cos(theta/2)I - i*sin(theta/2)(n.sigma),
    # the trace of U is Tr(U) = 2*cos(theta/2).
    # We take the real part to handle potential small numerical inaccuracies.
    cos_half_theta = np.real(np.trace(U)) / 2.0

    # Ensure the value is within the valid range for arccos to avoid domain errors
    cos_half_theta = np.clip(cos_half_theta, -1.0, 1.0)
    
    theta = 2 * np.arccos(cos_half_theta)

    # --- Step 3: Extract the rotation axis n from U ---
    # From the proof, we know that the components of the vector sin(theta/2)*n
    # can be extracted from the matrix U.
    # C_k = sin(theta/2) * n_k
    # We can find C_k using Tr(sigma_k * U) = -2i * C_k
    
    sin_half_theta = np.sin(theta / 2.0)

    # Handle the case where theta is 0 or a multiple of 2*pi (sin(theta/2) is zero)
    if np.isclose(sin_half_theta, 0):
        # If the rotation angle is zero, the axis is undefined.
        # We can return any unit vector, e.g., [1, 0, 0] or a zero vector.
        return theta, np.array([0.0, 0.0, 0.0])

    # Calculate Ck = (i/2) * Tr(sigma_k * U)
    c1 = (0.5j * np.trace(sigma1 @ U)).real
    c2 = (0.5j * np.trace(sigma2 @ U)).real
    c3 = (0.5j * np.trace(sigma3 @ U)).real

    # n_k = C_k / sin(theta/2)
    n = np.array([
        c1 / sin_half_theta,
        c2 / sin_half_theta,
        c3 / sin_half_theta
    ])

    # Normalize n to ensure it's a unit vector, correcting for any numerical errors
    norm_n = np.linalg.norm(n)
    if not np.isclose(norm_n, 0):
        n = n / norm_n

    return theta, n

# --- Example Usage ---
if __name__ == "__main__":
    # Example 1: A 90-degree rotation around x, then 90-degree around y, ...
    # These are Euler angles. For this sequence, the result is well-known.
    t1 = np.pi / 2  # 90 degrees
    t2 = np.pi / 2  # 90 degrees
    t3 = 0
    
    # Also calculate expected values from the formulas in the proof
    c1, s1 = np.cos(t1/2), np.sin(t1/2)
    c2, s2 = np.cos(t2/2), np.sin(t2/2)
    c3, s3 = np.cos(t3/2), np.sin(t3/2)

    # Expected C0 = cos(theta/2)
    expected_cos_half_theta = c1*c2*c3 - s1*s2*s3
    expected_theta = 2 * np.arccos(expected_cos_half_theta)
    
    # Expected Ck = sin(theta/2)*nk
    expected_c1 = s1*c2*c3 + c1*s2*s3
    expected_c2 = c1*s2*c3 - s1*c2*s3
    expected_c3 = c1*c2*s3 + s1*s2*c3
    expected_sin_n_vec = np.array([expected_c1, expected_c2, expected_c3])
    expected_n = expected_sin_n_vec / np.sin(expected_theta/2)


    # Run the numerical computation
    theta_computed, n_computed = compute_equivalent_rotation(t1, t2, t3)

    print("--- Example: Rotations of pi/2 around X, then pi/2 around Y ---")
    print(f"Input angles (rad): theta1={t1:.4f}, theta2={t2:.4f}, theta3={t3:.4f}")
    print("-" * 50)
    print(f"Computed Angle (theta): {theta_computed:.4f} rad")
    print(f"Computed Axis (n): {n_computed}")
    print("-" * 50)
    print("Expected values from analytical formulas:")
    print(f"Expected Angle (theta): {expected_theta:.4f} rad")
    print(f"Expected Axis (n): {expected_n}")
    print("\nNote: A 90-deg rot around x, then 90-deg around y is equivalent to a 120-deg rot around (1,1,1)/sqrt(3).")


