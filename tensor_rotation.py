import numpy as np
from scipy.linalg import block_diag

def rotation_matrix_z(theta):
    """Generate a rotation matrix for a rotation around the z-axis by angle theta."""
    return np.array([[np.cos(theta), -np.sin(theta), 0],
                     [np.sin(theta), np.cos(theta), 0],
                     [0, 0, 1]])

def get_M_theta(theta):
    """Construct the 5x5 D^(2) matrix for j=2 representation under z-axis rotation."""
    ct = np.cos(theta)
    st = np.sin(theta)
    ct2 = ct**2
    st2 = st**2
    stct = st * ct
    return np.array([
        [ct2, -2*stct, 0, st2, 0],
        [stct, ct2 - st2, 0, -stct, 0],
        [0, 0, ct, 0, -st],
        [st2, 2*stct, 0, ct2, 0],
        [0, 0, st, 0, ct]
    ])

def decompose_rank2_tensor(T):
    """Decompose a 3x3 tensor into trace, antisymmetric, and symmetric traceless parts."""
    trace = np.trace(T) / 3
    antisymmetric = (T - T.T) / 2
    symmetric = (T + T.T) / 2
    symmetric_traceless = symmetric - np.eye(3) * trace
    return trace, antisymmetric, symmetric_traceless

def flatten_tensor_components(trace, antisymmetric, symmetric_traceless):
    """
    Flatten the tensor components into a 9-component vector.

    The vector is ordered as: [trace, v_x, v_y, v_z, S_00, S_01, S_02, S_11, S_12]
    where v_x = -A_12, v_y = A_02, v_z = -A_01 from the antisymmetric part.
    """
    return np.array([
        trace,
        -antisymmetric[1, 2],  # v_x = -A_12
        antisymmetric[0, 2],   # v_y = A_02
        -antisymmetric[0, 1],  # v_z = -A_01
        symmetric_traceless[0, 0],
        symmetric_traceless[0, 1],
        symmetric_traceless[0, 2],
        symmetric_traceless[1, 1],
        symmetric_traceless[1, 2]
    ])


def construct_D_R(R):
    """Construct the full 9x9 D_R matrix for a rank-2 tensor (j=0, j=1, j=2)."""
    # j=0: 1x1 matrix (scalar representation)
    D_0 = np.array([[1]])
    # j=1: 3x3 rotation matrix (vector representation)
    D_1 = R
    # j=2: 5x5 matrix for symmetric traceless part
    theta = np.arctan2(R[1, 0], R[0, 0])
    D_2 = get_M_theta(theta)
    # Full 9x9 block diagonal matrix
    D_R = block_diag(D_0, D_1, D_2)
    return D_R

def reconstruct_tensor(v_transformed):
    """
    Reconstruct the 3x3 tensor from the transformed 9-component vector.

    The vector is expected to be in the order: [trace, v_x', v_y', v_z', S_00', S_01', S_02', S_11', S_12']
    where v_x', v_y', v_z' correspond to the transformed antisymmetric components.
    """
    A_prime = np.array([
        [0, -v_transformed[3], v_transformed[2]],  # [0, -v_z', v_y']
        [v_transformed[3], 0, -v_transformed[1]], # [v_z', 0, -v_x']
        [-v_transformed[2], v_transformed[1], 0]  # [-v_y', v_x', 0]
    ])
    S_prime = np.array([
        [v_transformed[4], v_transformed[5], v_transformed[6]],
        [v_transformed[5], v_transformed[7], v_transformed[8]],
        [v_transformed[6], v_transformed[8], -v_transformed[4] - v_transformed[7]]  # S_22' = -S_00' - S_11'
    ])
    T_prime = S_prime + A_prime + np.eye(3) * v_transformed[0]
    return T_prime

def apply_transformation_decomposition(T, R):
    """Transform a rank-2 tensor using the decomposition method with a single vector."""
    # Decompose the tensor
    trace, antisymmetric, symmetric_traceless = decompose_rank2_tensor(T)
    # Flatten into a single 9-component vector
    v = flatten_tensor_components(trace, antisymmetric, symmetric_traceless)
    # Construct the full D_R matrix
    D_R = construct_D_R(R)
    # Transform the vector
    v_transformed = np.dot(D_R, v)
    # Reconstruct the transformed tensor
    T_transformed = reconstruct_tensor(v_transformed)
    return T_transformed, D_R, v

def apply_transformation_direct(T, R):
    """Transform a rank-2 tensor directly using matrix multiplication."""
    return np.dot(R, np.dot(T, R.T))

def main():
    """Test the tensor transformation methods."""
    theta = np.pi / 2  # 90-degree rotation around z-axis
    R = rotation_matrix_z(theta)
    T = np.array([[1, 2, 3],
                  [4, 5, 6],
                  [7, 8, 9]])

    # Apply transformations
    T_transformed_decomp, D_R, v = apply_transformation_decomposition(T, R)
    T_transformed_direct = apply_transformation_direct(T, R)

    # Print results
    print("Original Tensor:\n", T)
    print("\nD_R Matrix (2 decimal places):")
    np.set_printoptions(precision=2, suppress=True, floatmode='fixed')
    print(D_R)
    print("\nv Vector (2 decimal places):")
    np.set_printoptions(precision=2, suppress=True, floatmode='fixed')
    print(v)
    np.set_printoptions()  # Reset to default
    print("\nDecomposition Method:\n", T_transformed_decomp)
    print("\nDirect Method:\n", T_transformed_direct)
    print("\nDifference:\n", np.abs(T_transformed_decomp - T_transformed_direct))

if __name__ == "__main__":
    main()
