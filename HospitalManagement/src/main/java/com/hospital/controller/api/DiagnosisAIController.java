package com.hospital.controller.api;

import com.google.gson.JsonArray;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.BufferedReader;
import java.io.FileReader;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.net.HttpURLConnection;
import java.net.URL;
import java.nio.charset.StandardCharsets;
import java.io.IOException;

@WebServlet("/api/diagnosis/ai")
public class DiagnosisAIController extends HttpServlet {

    private String getApiKeyFromEnv() {
        try (BufferedReader br = new BufferedReader(new FileReader("d:/HocKi225/LapTrinhMang/HospitalManagement/.env"))) {
            String line;
            while ((line = br.readLine()) != null) {
                if (line.startsWith("GROQ_API_KEY=")) {
                    return line.substring("GROQ_API_KEY=".length()).trim();
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    private String getDiagnosisSuggestions(String symptoms) {
        String apiKey = getApiKeyFromEnv();
        
        if (apiKey == null || apiKey.isEmpty() || apiKey.equals("your_api_key_here")) {
            return "<p class='text-danger'>Lỗi cấu hình API Key. Vui lòng kiểm tra lại file .env.</p>";
        }

        try {
            URL url = new URL("https://api.groq.com/openai/v1/chat/completions");
            HttpURLConnection connection = (HttpURLConnection) url.openConnection();
            connection.setRequestMethod("POST");
            connection.setRequestProperty("Authorization", "Bearer " + apiKey);
            connection.setRequestProperty("Content-Type", "application/json; charset=utf-8");
            connection.setDoOutput(true);

            String prompt = "Bạn là bác sĩ tư vấn. Triệu chứng: " + symptoms + ". Hãy chẩn đoán, nêu nguyên nhân và hướng xử lý. LƯU Ý QUAN TRỌNG: Câu trả lời PHẢI được định dạng 100% bằng thẻ HTML (dùng <p>, <b>, <ul>, <li>, <br>). TUYỆT ĐỐI KHÔNG dùng định dạng Markdown (như mất dấu **, *, #, -). Chỉ trả về mã HTML thành phẩm.";

            JsonObject payload = new JsonObject();
            payload.addProperty("model", "llama-3.1-8b-instant");
            JsonArray messages = new JsonArray();
            JsonObject message = new JsonObject();
            message.addProperty("role", "user");
            message.addProperty("content", prompt);
            messages.add(message);
            payload.add("messages", messages);
            payload.addProperty("temperature", 0.7);

            try (OutputStream os = connection.getOutputStream()) {
                byte[] input = payload.toString().getBytes(StandardCharsets.UTF_8);
                os.write(input, 0, input.length);
            }

            int code = connection.getResponseCode();
            if (code == 200) {
                try (BufferedReader br = new BufferedReader(new InputStreamReader(connection.getInputStream(), StandardCharsets.UTF_8))) {
                    StringBuilder response = new StringBuilder();
                    String responseLine;
                    while ((responseLine = br.readLine()) != null) {
                        response.append(responseLine.trim());
                    }
                    JsonObject jsonResponse = JsonParser.parseString(response.toString()).getAsJsonObject();
                    return jsonResponse.getAsJsonArray("choices").get(0).getAsJsonObject().getAsJsonObject("message").get("content").getAsString();
                }
            } else {
                StringBuilder errResponse = new StringBuilder();
                if (connection.getErrorStream() != null) {
                    try (BufferedReader errBr = new BufferedReader(new InputStreamReader(connection.getErrorStream(), StandardCharsets.UTF_8))) {
                        String errLine;
                        while ((errLine = errBr.readLine()) != null) {
                            errResponse.append(errLine.trim());
                        }
                    }
                }
                return "<p class='text-danger'>Lỗi khi gọi API (" + code + "): " + errResponse.toString() + "</p>";
            }

        } catch (Exception e) {
            e.printStackTrace();
            return "<p class='text-danger'>Lỗi hệ thống: " + e.getMessage() + "</p>";
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setContentType("application/json; charset=UTF-8");

        String symptoms = request.getParameter("symptoms");
        if (symptoms == null || symptoms.trim().isEmpty()) {
            JsonObject err = new JsonObject();
            err.addProperty("error", "Vui lòng nhập lời mô tả/chẩn đoán bệnh.");
            response.getWriter().write(err.toString());
            return;
        }

        // Gọi AI chẩn đoán
        String aiResponseHtml = getDiagnosisSuggestions(symptoms);
        
        JsonObject result = new JsonObject();
        result.addProperty("aiHtml", aiResponseHtml);
        
        response.getWriter().write(result.toString());
    }
}
