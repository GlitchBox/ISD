//const BASE_URL = "http://192.168.0.133:8000/api";
const MOCK_URL = "https://5cf132f13db50700145db61f.mockapi.io/api/auth/";
const BASE_URL = "https://5f0bf4db.ngrok.io/api/auth";
const LARAVEL_URL = "https://5f0bf4db.ngrok.io/api/auth/";
//const LARAVEL_URL = "http://192.168.31.193:8000/api/auth/";
//const LARAVEL_URL = "https://ae4de439.ngrok.io/api/auth/";
//const LOGIN_URL=MOCK_URL+"Users";
const LOGIN_URL = LARAVEL_URL + "mobile-login";
//const REG_URL=MOCK_URL+"Register";
const REG_URL = LARAVEL_URL + "mobile-register";
//const TOP_URL=MOCK_URL+"Topic";
const TOP_URL = LARAVEL_URL + "mobile-topics";
//const MCQ_URL=MOCK_URL+"MCQ";
const MCQ_URL = LARAVEL_URL + "mobile-getmcq";
const DETAILS_URL = LARAVEL_URL + "mobile-details";
const FB_URL = LARAVEL_URL + "mobile-getfillintheblanks";
const TF_URL = LARAVEL_URL + "mobile-gettruefalse";
const SM_URL = LARAVEL_URL + "mobile-getSentenceMatching";
//const PW_URL=MOCK_URL+'PictureWord';
//const WP_URL=MOCK_URL+'WordPicture';
const PW_URL=LARAVEL_URL+'mobile-get-picture-to-word';
const WP_URL=LARAVEL_URL+'mobile-get-word-to-picture';
const SME_URL = BASE_URL+"/mobile-get-eng-to-eng-sentence-matching";
//const FB_URL = BASE_URL+"/mobile-getfillintheblanks";
//const SM_URL = BASE_URL+"/mobile-getSentenceMatching";
//const SME_URL = BASE_URL+"/mobile-get-eng-to-eng-sentence-matching";
//const MCQ_URL = BASE_URL+"/mobile-getmcq";
const JUMBLED_URL = BASE_URL+"/mobile-get-fixed-jumbled-sentence";
const MG_URL=LARAVEL_URL+"mobile-get-memory-game";

const MIXTASK_URL = BASE_URL+"/mobile-getalltask";

const TOKEN = "Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiIsImp0aSI6IjYzYzg4NDIxNzZkMDg0MWY4MWZkY2FmYTc1MzE4OWRlMTdhMmVmNWNjZGE1NzBlYzJmY2YwYWExNmNlYWE4ODZlNTliOGVlYThmZjI5NzA2In0.eyJhdWQiOiIxIiwianRpIjoiNjNjODg0MjE3NmQwODQxZjgxZmRjYWZhNzUzMTg5ZGUxN2EyZWY1Y2NkYTU3MGVjMmZjZjBhYTE2Y2VhYTg4NmU1OWI4ZWVhOGZmMjk3MDYiLCJpYXQiOjE1NjE0NDY3MTAsIm5iZiI6MTU2MTQ0NjcxMCwiZXhwIjoxNTkzMDY5MTEwLCJzdWIiOiI0Iiwic2NvcGVzIjpbXX0.NC6kpY8acLIVSsnPWw7T8M0i1NAX5U1Upy4TRSUiqBGIzUb5Oal20eY5Wrq7tdBkbZoIKTN0Cmhb7IKp31vFeq1dA0cVkRKXDHbXG7IfBlZ_IUFb3dWbINrtlrlVAC8c19fLojSehGNDT6tJ68fEi6AWqpER-BppqCTkEQiWXMehMfoVtUnOQsyCzhJ_oimTt1wrOBSQMNY1lgkiaKYTQoutu9-7HRgGmwV9ztXpYHZRfWz6zapCE6Pfl_mDFapTBJ6kOM1jfLkhxALdz3lwH1739Hmy_TGCZzGSLMLSBp80hcpfeBah3sMIo2ljAoGX_-7KEjb1H8GSS6p1la5bUHSUZWxe6uAHzB0vDMWVFNkcjJ2gZx-qTF7y9eW7K9d64M_SS3Azoo7zq9wRgzucaTi1cI-TFrqWMyMpVaP3pMerLwAb7SFVAKZRToDBwkAWP29Dc_EfiVRHbL4iwWqz-Kvete5TcKrJ-G_WB4A80JD8DxmnNOPeY7iu02gybdkcG-5iTMKtVowsAWMuLSTLsEjh9_xcZSXCOZP0pRzWLdfk-koVWXusreX0pmVq96iQ8M67F4VYrbWHhjVMPgBKHUh_4JVKpVZWDDYwgmFpKx1zsxFE2_NMywAnnXpbMk3SKWI1ljm6Gv1y77E4I1hfASsd1NWw0zbk6mL46VWnkoQ";
