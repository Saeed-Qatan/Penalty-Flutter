/// Defines the context/purpose of the OTP flow.
/// Used to determine the correct Supabase OtpType for verification and resend.
enum OtpPurpose {
  /// OTP for confirming a new user's email after sign-up.
  signup,

  /// OTP for password recovery (forgot password).
  recovery,
}
