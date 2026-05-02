import { useState, useEffect } from 'react';
import { createClient } from '@supabase/supabase-js';
import { LockKeyhole, Eye, EyeOff, XCircle, CheckCircle2 } from 'lucide-react';

const SUPABASE_URL = 'https://rscgxudheornmajpwtok.supabase.co';
const SUPABASE_ANON_KEY = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InJzY2d4dWRoZW9ybm1hanB3dG9rIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NzUyMTk0MzYsImV4cCI6MjA5MDc5NTQzNn0.G_UHmqzVmmRyTjIKodaZCCzksxZjoZZ-UPAUSQGzw0E';
const supabase = createClient(SUPABASE_URL, SUPABASE_ANON_KEY, {
  auth: {
    detectSessionInUrl: false, // Turn off auto parsing to avoid race conditions
    autoRefreshToken: false,
    persistSession: true
  }
});

function App() {
  const [viewState, setViewState] = useState('loading'); // loading, error, form, success
  const [errorMsg, setErrorMsg] = useState('');
  
  const [newPassword, setNewPassword] = useState('');
  const [confirmPassword, setConfirmPassword] = useState('');
  const [showNewPassword, setShowNewPassword] = useState(false);
  const [showConfirmPassword, setShowConfirmPassword] = useState(false);
  
  const [strength, setStrength] = useState('none');
  const [isSubmitting, setIsSubmitting] = useState(false);

  useEffect(() => {
    const initSession = async () => {
      try {
        // 1. Check for PKCE flow (e.g. ?code=...)
        const queryParams = new URLSearchParams(window.location.search);
        const code = queryParams.get('code');

        // 2. Check for implicit flow (e.g. #access_token=...)
        const hash = window.location.hash.substring(1);
        const hashParams = new URLSearchParams(hash);
        const accessToken = hashParams.get('access_token');
        const refreshToken = hashParams.get('refresh_token');
        
        // Supabase often appends errors here if the token was consumed or invalid
        const serverError = hashParams.get('error_description') || queryParams.get('error_description') || hashParams.get('error') || queryParams.get('error');

        if (serverError) {
          setErrorMsg(`رسالة من الخادم: ${decodeURIComponent(serverError.replace(/\+/g, ' '))}`);
          setViewState('error');
          return;
        }

        if (code) {
          // Handle PKCE Code Exchange
          const { error } = await supabase.auth.exchangeCodeForSession(code);
          if (error) {
            setErrorMsg(error.message || 'انتهت صلاحية رمز التحقق (Code).');
            setViewState('error');
            return;
          }
        } else if (accessToken) {
          // Handle Implicit Flow Session Set
          const { error } = await supabase.auth.setSession({
            access_token: accessToken,
            refresh_token: refreshToken,
          });
          if (error) {
            setErrorMsg(error.message || 'انتهت صلاحية رمز الوصول (Token).');
            setViewState('error');
            return;
          }
        } else {
          // Neither code nor token exists
          setErrorMsg('هذا الرابط لا يحتوي على بيانات مصادقة صحيحة. يرجى طلب رابط جديد.');
          setViewState('error');
          return;
        }

        // Successfully authenticated
        setViewState('form');
        
        // Clean URL for security
        window.history.replaceState(null, '', window.location.pathname);

      } catch (err) {
        setErrorMsg('حدث خطأ أثناء قراءة الرابط.');
        setViewState('error');
      }
    };

    initSession();
  }, []);

  const calculateStrength = (password) => {
    if (!password) return 'none';
    const hasLetters = /[a-zA-Z]/.test(password);
    const hasNumbers = /[0-9]/.test(password);
    const hasSymbols = /[!@#$&*~]/.test(password);
    
    if (password.length >= 8 && hasLetters && hasNumbers && hasSymbols) return 'strong';
    if (password.length >= 6 && hasLetters && hasNumbers) return 'medium';
    return 'weak';
  };

  const handlePasswordChange = (e) => {
    const val = e.target.value;
    setNewPassword(val);
    setStrength(calculateStrength(val));
    setErrorMsg('');
  };

  const handleSubmit = async (e) => {
    e.preventDefault();
    if (newPassword.length < 8) {
      setErrorMsg('كلمة المرور يجب أن تكون 8 أحرف على الأقل');
      return;
    }
    if (newPassword !== confirmPassword) {
      setErrorMsg('كلمات المرور غير متطابقة');
      return;
    }

    setIsSubmitting(true);
    setErrorMsg('');

    try {
      const { error } = await supabase.auth.updateUser({ password: newPassword });
      if (error) throw error;
      setViewState('success');
    } catch (err) {
      setErrorMsg(err.message || 'حدث خطأ أثناء الاتصال بالخادم.');
    } finally {
      setIsSubmitting(false);
    }
  };

  // --- Render Helpers ---
  const renderStrengthBars = () => {
    let classes = ['bg-divider', 'bg-divider', 'bg-divider'];
    let text = '';
    let textColor = '';

    if (strength === 'strong') {
      classes = ['bg-neon-green', 'bg-neon-green', 'bg-neon-green'];
      text = 'Strong 💪';
      textColor = 'text-neon-green';
    } else if (strength === 'medium') {
      classes = ['bg-amber-500', 'bg-amber-500', 'bg-divider'];
      text = 'Medium';
      textColor = 'text-amber-500';
    } else if (strength === 'weak') {
      classes = ['bg-error', 'bg-divider', 'bg-divider'];
      text = 'Weak';
      textColor = 'text-error';
    }

    return (
      <div className="mt-2">
        <div className="flex gap-1.5 mb-1 h-1">
          <div className={`flex-1 rounded-full transition-colors ${classes[0]}`}></div>
          <div className={`flex-1 rounded-full transition-colors ${classes[1]}`}></div>
          <div className={`flex-1 rounded-full transition-colors ${classes[2]}`}></div>
        </div>
        {text && <div className={`text-xs text-left ltr ${textColor}`}>{text}</div>}
      </div>
    );
  };

  return (
    <div className="relative min-h-screen flex items-center justify-center p-5">
      {/* Background glow effects */}
      <div className="fixed -top-[200px] -right-[200px] w-[600px] h-[600px] rounded-full bg-neon-green/10 blur-[100px] pointer-events-none z-0"></div>
      <div className="fixed -bottom-[200px] -left-[200px] w-[400px] h-[400px] rounded-full bg-blue-500/10 blur-[100px] pointer-events-none z-0"></div>

      <div className="w-full max-w-[440px] relative z-10">
        <div className="bg-surface border border-border rounded-3xl p-8 sm:p-10 shadow-2xl shadow-black/40 animate-in fade-in slide-in-from-bottom-8 duration-500">
          
          {viewState === 'loading' && (
            <div className="text-center py-10">
              <div className="w-12 h-12 border-4 border-divider border-t-neon-green rounded-full animate-spin mx-auto mb-5"></div>
              <p className="text-text-secondary text-[15px]">جاري التحقق...</p>
            </div>
          )}

          {viewState === 'error' && (
            <div className="text-center py-5">
              <div className="w-20 h-20 rounded-full bg-error/10 border-2 border-error/30 flex items-center justify-center mx-auto mb-5 text-error">
                <XCircle size={36} />
              </div>
              <h2 className="text-[22px] font-bold mb-2.5">رابط غير صالح</h2>
              <p className="text-text-secondary text-[15px] leading-relaxed mb-6">{errorMsg}</p>
            </div>
          )}

          {viewState === 'success' && (
            <div className="text-center py-5">
              <div className="w-24 h-24 rounded-full bg-app-bg border-[3px] border-neon-green flex items-center justify-center mx-auto mb-6 glow-green-strong text-neon-green scale-in">
                <CheckCircle2 size={48} />
              </div>
              <h2 className="text-2xl font-bold mb-3">تم بنجاح! ✅</h2>
              <p className="text-text-secondary text-[15px] leading-relaxed mb-7">
                تم إعادة تعيين كلمة المرور بنجاح.<br />يمكنك الآن تسجيل الدخول بكلمة المرور الجديدة من التطبيق.
              </p>
            </div>
          )}

          {viewState === 'form' && (
            <div>
              <div className="flex justify-center mb-7">
                <div className="w-20 h-20 rounded-full bg-app-bg border-2 border-neon-green/20 flex items-center justify-center glow-green text-neon-green animate-pulse">
                  <LockKeyhole size={36} />
                </div>
              </div>

              <h1 className="text-center text-[26px] font-bold mb-2">إعادة تعيين كلمة المرور</h1>
              <p className="text-center text-text-secondary text-[15px] mb-8">أنشئ كلمة مرور جديدة وقوية لحسابك</p>

              {errorMsg && (
                <div className="bg-error/10 text-red-300 border border-error/20 p-3 rounded-xl text-sm font-medium mb-5 animate-in fade-in slide-in-from-top-2">
                  {errorMsg}
                </div>
              )}

              <form onSubmit={handleSubmit} className="space-y-5">
                <div>
                  <label className="block text-sm font-semibold text-text-tertiary mb-2">كلمة المرور الجديدة</label>
                  <div className="relative">
                    <input
                      type={showNewPassword ? "text" : "password"}
                      value={newPassword}
                      onChange={handlePasswordChange}
                      className="w-full bg-app-bg border border-divider rounded-xl py-3.5 px-4 pl-12 text-white outline-none focus:border-neon-green focus:ring-1 focus:ring-neon-green transition-all placeholder-text-secondary"
                      placeholder="••••••••"
                      required
                    />
                    <button
                      type="button"
                      onClick={() => setShowNewPassword(!showNewPassword)}
                      className="absolute left-3 top-1/2 -translate-y-1/2 text-text-tertiary hover:text-white transition-colors"
                    >
                      {showNewPassword ? <EyeOff size={20} /> : <Eye size={20} />}
                    </button>
                  </div>
                  {renderStrengthBars()}
                </div>

                <div>
                  <label className="block text-sm font-semibold text-text-tertiary mb-2">تأكيد كلمة المرور الجديدة</label>
                  <div className="relative">
                    <input
                      type={showConfirmPassword ? "text" : "password"}
                      value={confirmPassword}
                      onChange={(e) => {
                        setConfirmPassword(e.target.value);
                        setErrorMsg('');
                      }}
                      className="w-full bg-app-bg border border-divider rounded-xl py-3.5 px-4 pl-12 text-white outline-none focus:border-neon-green focus:ring-1 focus:ring-neon-green transition-all"
                      placeholder="••••••••"
                      required
                    />
                    <button
                      type="button"
                      onClick={() => setShowConfirmPassword(!showConfirmPassword)}
                      className="absolute left-3 top-1/2 -translate-y-1/2 text-text-tertiary hover:text-white transition-colors"
                    >
                      {showConfirmPassword ? <EyeOff size={20} /> : <Eye size={20} />}
                    </button>
                  </div>
                </div>

                <div className="pt-2">
                  <button
                    type="submit"
                    disabled={isSubmitting}
                    className="w-full py-4 bg-neon-green text-app-bg rounded-xl text-[17px] font-bold btn-shadow transition-all disabled:opacity-50 disabled:hover:shadow-none"
                  >
                    {isSubmitting ? (
                      <div className="w-5 h-5 border-2 border-app-bg border-t-transparent rounded-full animate-spin mx-auto"></div>
                    ) : (
                      'إعادة تعيين كلمة المرور'
                    )}
                  </button>
                </div>
              </form>
            </div>
          )}
        </div>

        <p className="text-center mt-6 text-[13px] text-text-secondary">
          Powered by <strong className="text-neon-green">PLENALTY</strong> ⚽
        </p>
      </div>
    </div>
  );
}

export default App;
