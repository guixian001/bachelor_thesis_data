local ffi = require [[ffi]]

ffi.cdef([[
/* A ROWS x COLS matrix with complex elements */

struct quantum_matrix_struct {
  int rows;
  int cols;
  float _Complex *t;
};

typedef struct quantum_matrix_struct quantum_matrix;

/* The quantum register */

struct quantum_reg_struct
{
  int width; /* number of qubits in the qureg */
  int size; /* number of non-zero vectors */
  int hashw; /* width of the hash array */
  float _Complex *amplitude;
  unsigned long long *state;
  int *hash;
};

typedef struct quantum_reg_struct quantum_reg;

struct quantum_density_op_struct
{
  int num; /* total number of state vectors */
  float *prob; /* probabilities of the state vectors */
  quantum_reg *reg; /* state vectors */
};

typedef struct quantum_density_op_struct quantum_density_op;

enum {
  QUANTUM_SOLVER_LANCZOS,
  QUANTUM_SOLVER_LANCZOS_MODIFIED,
  QUANTUM_SOLVER_IMAGINARY_TIME
};

extern quantum_reg quantum_new_qureg(unsigned long long initval, int width);
extern quantum_reg quantum_new_qureg_size(int n, int width);
extern quantum_reg quantum_new_qureg_sparse(int n, int width);
extern void quantum_delete_qureg(quantum_reg *reg);
extern void quantum_print_qureg(quantum_reg reg);
extern void quantum_addscratch(int bits, quantum_reg *reg);
extern void quantum_print_timeop(int width, void f(quantum_reg *));

extern void quantum_cnot(int control, int target, quantum_reg *reg);
extern void quantum_toffoli(int control1, int control2, int target,
       quantum_reg *reg);
extern void quantum_unbounded_toffoli(int controlling, quantum_reg *reg, ...);
extern void quantum_sigma_x(int target, quantum_reg *reg);
extern void quantum_sigma_y(int target, quantum_reg *reg);
extern void quantum_sigma_z(int target, quantum_reg *reg);
extern void quantum_gate1(int target, quantum_matrix m, quantum_reg *reg);
extern void quantum_gate2(int target1, int target2, quantum_matrix m,
     quantum_reg *reg);
extern void quantum_r_x(int target, float gamma, quantum_reg *reg);
extern void quantum_r_y(int target, float gamma, quantum_reg *reg);
extern void quantum_r_z(int target, float gamma, quantum_reg *reg);
extern void quantum_phase_scale(int target, float gamma, quantum_reg *reg);
extern void quantum_phase_kick(int target, float gamma, quantum_reg *reg);
extern void quantum_hadamard(int target, quantum_reg *reg);
extern void quantum_walsh(int width, quantum_reg *reg);
extern void quantum_cond_phase(int control, int target, quantum_reg *reg);
extern void quantum_cond_phase_inv(int control, int target, quantum_reg *reg);
extern void quantum_cond_phase_kick(int control, int target, float gamma,
        quantum_reg *reg);
extern void quantum_cond_phase_shift(int control, int target, float gamma,
        quantum_reg *reg);
extern int quantum_gate_counter(int inc);

extern void quantum_qft(int width, quantum_reg *reg);
extern void quantum_qft_inv(int width, quantum_reg *reg);

extern void quantum_exp_mod_n(int N, int x, int width_input, int width,
         quantum_reg *reg);

extern unsigned long long quantum_measure(quantum_reg reg);
extern int quantum_bmeasure(int pos, quantum_reg *reg);
extern int quantum_bmeasure_bitpreserve(int pos, quantum_reg *reg);

extern quantum_matrix quantum_new_matrix(int cols, int rows);
extern void quantum_delete_matrix(quantum_matrix *m);
extern quantum_matrix quantum_mmult(quantum_matrix A, quantum_matrix B);

extern int quantum_ipow(int a, int b);
extern int quantum_gcd(int u, int v);
extern void quantum_cancel(int *a, int *b);
extern void quantum_frac_approx(int *a, int *b, int width);
extern int quantum_getwidth(int n);

extern double quantum_prob(float _Complex a);

extern float quantum_get_decoherence();
extern void quantum_set_decoherence(float lambda);
extern void quantum_decohere(quantum_reg *reg);

extern quantum_reg quantum_matrix2qureg(quantum_matrix *m, int width);
extern quantum_matrix quantum_qureg2matrix(quantum_reg reg);
extern quantum_reg quantum_kronecker(quantum_reg *reg1, quantum_reg *reg2);
extern float _Complex quantum_dot_product(quantum_reg *reg1, quantum_reg *reg2);
extern quantum_reg quantum_vectoradd(quantum_reg *reg1, quantum_reg *reg2);
extern void quantum_vectoradd_inplace(quantum_reg *reg1, quantum_reg *reg2);
extern quantum_reg quantum_matrix_qureg(quantum_reg A(unsigned long long, double),
     double t, quantum_reg *reg, int flags);
extern void quantum_scalar_qureg(float _Complex r, quantum_reg *reg);
extern void quantum_print_timeop(int width, void f(quantum_reg *));

extern void quantum_qec_encode(int type, int width, quantum_reg *reg);
extern void quantum_qec_decode(int type, int width, quantum_reg *reg);

extern const char * quantum_get_version();

extern void quantum_objcode_start();
extern void quantum_objcode_stop();
extern int quantum_objcode_write(char *file);
extern void quantum_objcode_run(char *file, quantum_reg *reg);

extern quantum_density_op quantum_new_density_op(int num, float *prob,
       quantum_reg *reg);
extern quantum_density_op quantum_qureg2density_op(quantum_reg *reg);
extern void quantum_reduced_density_op(int pos, quantum_density_op *rho);
extern quantum_matrix quantum_density_matrix(quantum_density_op *rho);
extern void quantum_print_density_matrix(quantum_density_op *rho);
extern void quantum_delete_density_op(quantum_density_op *rho);
extern float quantum_purity(quantum_density_op *rho);

extern void *quantum_error_handler(void *f(int));
extern const char *quantum_strerr(int errno);
extern void quantum_error(int errno);

extern void quantum_rk4(quantum_reg *reg, double t, double dt,
   quantum_reg H(unsigned long long, double), int flags);
extern double quantum_rk4a(quantum_reg *reg, double t, double *dt,
      double epsilon,
      quantum_reg H(unsigned long long, double), int flags);

extern void quantum_diag_time(double t, quantum_reg *reg0, quantum_reg *regt,
         quantum_reg *tmp1, quantum_reg *tmp2,
         quantum_matrix H, float **w);


extern double quantum_groundstate(quantum_reg *reg, double epsilon,
      quantum_reg H(unsigned long long, double),
      int solver, double stepsize);
]])

return ffi.load [[quantum]]
