/* eslint-disable max-len, require-jsdoc, @typescript-eslint/no-unused-vars */

import * as functions from "firebase-functions";
import sgMail from "@sendgrid/mail";
import {Request, Response} from "express";

// Read SendGrid config from environment variables (.env in functions/)
const sendgridKey = process.env.SENDGRID_API_KEY;
const sendgridFrom = process.env.SENDGRID_FROM;

if (!sendgridKey || !sendgridFrom) {
  console.warn(
    "SendGrid env vars are missing. " +
    "Set SENDGRID_API_KEY and SENDGRID_FROM in functions/.env"
  );
} else {
  sgMail.setApiKey(sendgridKey);
}

/**
 * HTTP Function:
 *  - channel: "email"
 *  - to: destination email
 *  - code: OTP code
 */
type SupportedLang = "ar" | "tr" | "en";

interface EmailTemplate {
  subject: string;
  text: string;
  html: string;
}
function buildEmailTemplate(
  lang: SupportedLang,
  code: string
): EmailTemplate {
  switch (lang) {
  case "ar":
    return {
      subject: "رمز التحقق من بتنا للعقارات",
      text: `شكرًا لتواصلك مع شركة بتنا للعقارات.\n\nرمز التحقق الخاص بك هو: ${code}\n\nيرجى إدخال هذا الرمز في الصفحة لإكمال إرسال طلب بيع الشقة.\n\nإذا لم تكن أنت من طلب هذا الرمز، فيمكنك تجاهل هذه الرسالة.\n\nمع أطيب التحيات،\nفريق بتنا للعقارات`,
      html: `
 <html dir="rtl" lang="ar">
   <body style="background-color:#f5f5f5;margin:0;padding:24px;font-family:Tahoma,Arial,sans-serif;">
     <div style="max-width:480px;margin:0 auto;background-color:#ffffff;border-radius:12px;overflow:hidden;border:1px solid #e0e0e0;">
       <div style="background:linear-gradient(135deg,#211522,#740247);padding:16px 20px;color:#ffffff;">
         <h1 style="margin:0;font-size:18px;">بتنا للعقارات</h1>
         <p style="margin:4px 0 0;font-size:13px;opacity:0.9;">رمز التحقق لإرسال طلبك</p>
       </div>
       <div style="padding:20px;">
         <p style="margin:0 0 12px;font-size:14px;">شكرًا لتواصلك مع <strong>بتنا للعقارات</strong>.</p>
         <p style="margin:0 0 12px;font-size:14px;">رمز التحقق الخاص بك هو:</p>
         <div style="text-align:center;margin:16px 0;">
           <span style="
             display:inline-block;
             padding:10px 24px;
             border-radius:999px;
             background-color:#740247;
             color:#ffffff;
             font-size:22px;
             letter-spacing:4px;
             font-weight:bold;
           ">
             ${code}
           </span>
         </div>
         <p style="margin:0 0 12px;font-size:13px;color:#555;">
           يرجى إدخال هذا الرمز في صفحة الطلب لإكمال إرسال طلب بيع الشقة.
         </p>
         <p style="margin:0 0 12px;font-size:12px;color:#777;line-height:1.6;">
           إذا لم تكن أنت من طلب هذا الرمز، فيمكنك تجاهل هذه الرسالة، ولن يتم تنفيذ أي إجراء.
         </p>
         <p style="margin:16px 0 0;font-size:13px;color:#444;">
           مع أطيب التحيات،<br/>
           <strong>فريق بتنا للعقارات</strong>
         </p>
       </div>
       <div style="padding:10px 16px;background-color:#fafafa;border-top:1px solid #eee;text-align:center;">
         <span style="font-size:11px;color:#999;">© ${new Date().getFullYear()} بتنا للعقارات. جميع الحقوق محفوظة.</span>
       </div>
     </div>
   </body>
 </html>`,
    };

  case "tr":
    return {
      subject: "Betna Gayrimenkul doğrulama kodunuz",
      text: `Betna Gayrimenkul ile iletişime geçtiğiniz için teşekkür ederiz.\n\nDoğrulama kodunuz: ${code}\n\nLütfen bu kodu daire satış talebi formunda ilgili alana girin.\n\nEğer bu kodu siz talep etmediyseniz, bu e-postayı yok sayabilirsiniz.\n\nSaygılarımızla,\nBetna Gayrimenkul Ekibi`,
      html: `
 <html lang="tr">
   <body style="background-color:#f5f5f5;margin:0;padding:24px;font-family:-apple-system,BlinkMacSystemFont,'Segoe UI',Roboto,Arial,sans-serif;">
     <div style="max-width:480px;margin:0 auto;background-color:#ffffff;border-radius:12px;overflow:hidden;border:1px solid #e0e0e0;">
       <div style="background:linear-gradient(135deg,#211522,#740247);padding:16px 20px;color:#ffffff;">
         <h1 style="margin:0;font-size:18px;">Betna Gayrimenkul</h1>
         <p style="margin:4px 0 0;font-size:13px;opacity:0.9;">Doğrulama kodunuz</p>
       </div>
       <div style="padding:20px;">
         <p style="margin:0 0 12px;font-size:14px;">Betna Gayrimenkul ile iletişime geçtiğiniz için teşekkür ederiz.</p>
         <p style="margin:0 0 12px;font-size:14px;">Doğrulama kodunuz:</p>
         <div style="text-align:center;margin:16px 0;">
           <span style="
             display:inline-block;
             padding:10px 24px;
             border-radius:999px;
             background-color:#740247;
             color:#ffffff;
             font-size:22px;
             letter-spacing:4px;
             font-weight:bold;
           ">
             ${code}
           </span>
         </div>
         <p style="margin:0 0 12px;font-size:13px;color:#555;">
           Lütfen bu kodu daire satış talebi formunda ilgili alana girerek işlemi tamamlayın.
         </p>
         <p style="margin:0 0 12px;font-size:12px;color:#777;line-height:1.6;">
           Eğer bu kodu siz talep etmediyseniz, bu e-postayı yok sayabilirsiniz.
         </p>
         <p style="margin:16px 0 0;font-size:13px;color:#444;">
           Saygılarımızla,<br/>
           <strong>Betna Gayrimenkul Ekibi</strong>
         </p>
       </div>
       <div style="padding:10px 16px;background-color:#fafafa;border-top:1px solid #eee;text-align:center;">
         <span style="font-size:11px;color:#999;">© ${new Date().getFullYear()} Betna Gayrimenkul. Tüm hakları saklıdır.</span>
       </div>
     </div>
   </body>
 </html>`,
    };

  case "en":
  default:
    return {
      subject: "Your verification code – Betna Real Estate",
      text: `Thank you for contacting Betna Real Estate.\n\nYour verification code is: ${code}\n\nPlease enter this code on the request page to complete your apartment sale request.\n\nIf you did not request this code, you can safely ignore this email.\n\nBest regards,\nBetna Real Estate Team`,
      html: `
 <html lang="en">
   <body style="background-color:#f5f5f5;margin:0;padding:24px;font-family:-apple-system,BlinkMacSystemFont,'Segoe UI',Roboto,Arial,sans-serif;">
     <div style="max-width:480px;margin:0 auto;background-color:#ffffff;border-radius:12px;overflow:hidden;border:1px solid #e0e0e0;">
       <div style="background:linear-gradient(135deg,#211522,#740247);padding:16px 20px;color:#ffffff;">
         <h1 style="margin:0;font-size:18px;">Betna Real Estate</h1>
         <p style="margin:4px 0 0;font-size:13px;opacity:0.9;">Your verification code</p>
       </div>
       <div style="padding:20px;">
         <p style="margin:0 0 12px;font-size:14px;">Thank you for contacting <strong>Betna Real Estate</strong>.</p>
         <p style="margin:0 0 12px;font-size:14px;">Your verification code is:</p>
         <div style="text-align:center;margin:16px 0;">
           <span style="
             display:inline-block;
             padding:10px 24px;
             border-radius:999px;
             background-color:#740247;
             color:#ffffff;
             font-size:22px;
             letter-spacing:4px;
             font-weight:bold;
           ">
             ${code}
           </span>
         </div>
         <p style="margin:0 0 12px;font-size:13px;color:#555;">
           Please enter this code on the request page to complete your apartment sale submission.
         </p>
         <p style="margin:0 0 12px;font-size:12px;color:#777;line-height:1.6;">
           If you did not request this code, you can safely ignore this email and no action will be taken.
         </p>
         <p style="margin:16px 0 0;font-size:13px;color:#444;">
           Best regards,<br/>
           <strong>Betna Real Estate Team</strong>
         </p>
       </div>
       <div style="padding:10px 16px;background-color:#fafafa;border-top:1px solid #eee;text-align:center;">
         <span style="font-size:11px;color:#999;">© ${new Date().getFullYear()} Betna Real Estate. All rights reserved.</span>
       </div>
     </div>
   </body>
 </html>`,
    };
  }
}
export const sendVerificationCode = functions.https.onRequest(
  async (req: Request, res: Response): Promise<void> => {
    // ✅ إعداد هيدرات CORS
    res.set("Access-Control-Allow-Origin", "*"); // أو ضع دومينك بدلاً من *
    res.set("Access-Control-Allow-Headers", "Content-Type");
    res.set("Access-Control-Allow-Methods", "POST, OPTIONS");

    const body = req.body || {};
    const channel = body.channel;
    const to = body.to;
    const code = body.code;
    const langRaw = body.lang as string | undefined;

    const lang: SupportedLang =
      langRaw === "ar" || langRaw === "tr" ? langRaw : "en";


    // ✅ ردّ على preflight (OPTIONS) مباشرة
    if (req.method === "OPTIONS") {
      res.status(204).send("");
      return;
    }

    if (req.method !== "POST") {
      res.status(405).send("Method Not Allowed");
      return;
    }

    try {
      const body = req.body || {};
      const channel = body.channel;
      const to = body.to;
      const code = body.code;

      if (!channel || !to || !code) {
        res.status(400).json({error: "Missing channel, to, or code"});
        return;
      }

      if (channel !== "email") {
        res.status(400).json({error: "Only 'email' channel is supported"});
        return;
      }

      if (!sendgridKey || !sendgridFrom) {
        res.status(500).json({error: "SendGrid is not configured"});
        return;
      }

      const template = buildEmailTemplate(lang, code);

      const msg = {
        to,
        from: sendgridFrom,
        subject: template.subject,
        text: template.text,
        html: template.html,
      };

      await sgMail.send(msg);

      res.json({success: true});
    } catch (err: unknown) {
      console.error("Error sending verification code:", err);

      let message = "Internal error";
      if (err instanceof Error) {
        message = err.message || message;
      } else if (typeof err === "string") {
        message = err;
      }

      res.status(500).json({error: message});
    }
  }
);
