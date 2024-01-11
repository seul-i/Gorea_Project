package com.gorea.service_contents;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.io.UnsupportedEncodingException;
import java.net.URL;
import java.net.URLEncoder;

import java.util.ArrayList;
import java.util.List;

import javax.net.ssl.HttpsURLConnection;
import org.springframework.stereotype.Service;
import com.gorea.dto_board.Gorea_TrendSeoul_ListTO;

import org.json.JSONObject;

@Service
public class Gorea_TrendSeoul_Translation{

	private String lang_code;
    private final String clientId = "_E33NYWf762hSthWYBrk";
    private final String clientSecret = "4lLah4YOz7";

//    public Gorea_TrendSeoul_Translation() {
//    	
//    	Gorea_PAPAGO_Config papago = new Gorea_PAPAGO_Config();
//    	
//        this.clientId = papago.getPapagoApiKey();
//        this.clientSecret = papago.getPapagoApiSecret();
//        
//        System.out.println(clientId+"/"+clientSecret);
//    }
    
    public List<Gorea_TrendSeoul_ListTO> translateBoardList(List<Gorea_TrendSeoul_ListTO> boardList, String lang_code) {
    	
        this.lang_code = lang_code;


        for (Gorea_TrendSeoul_ListTO board : boardList) {
        	
            try {
            	
            	// 필드가 JSON 데이터인 경우
                String translatedTitle = translateText(board.getSeoulTitle(), clientId, clientSecret);
                String translatedLocGu = translateText(board.getSeoulLocGu(), clientId, clientSecret);
                String translatedMainCategory = translateText(board.getMainCategory(), clientId, clientSecret);
                String translatedSubCategory = translateText(board.getSubCategory(), clientId, clientSecret);

                String jsonData1 = translatedTitle;
                JSONObject json1 = new JSONObject(jsonData1);
                String TitleText = json1.getJSONObject("message").getJSONObject("result").getString("translatedText");
                
                String jsonData2 = translatedLocGu;
                JSONObject json2 = new JSONObject(jsonData2);
                String LocGuText = json2.getJSONObject("message").getJSONObject("result").getString("translatedText");
                
                String jsonData3 = translatedMainCategory;
                JSONObject json3 = new JSONObject(jsonData3);
                String MainCategoryText = json3.getJSONObject("message").getJSONObject("result").getString("translatedText");
                
                String jsonData4 = translatedSubCategory;
                JSONObject json4 = new JSONObject(jsonData4);
                String SubCategoryText = json4.getJSONObject("message").getJSONObject("result").getString("translatedText");
                
                // 번역된 결과를 다시 설정
                board.setSeoulTitle(TitleText);
                board.setSeoulLocGu(LocGuText);
                board.setMainCategory(MainCategoryText);
                board.setSubCategory(SubCategoryText);
                
            } catch (UnsupportedEncodingException e) {
            	
                System.out.println("에러 : " + e.getMessage());
            }
            
        }
        
        System.out.println(boardList);

        return boardList;
    }
    
	// 텍스트를 파파고 API를 사용하여 번역하는 메서드
    private String translateText(String text, String clientId, String clientSecret) throws UnsupportedEncodingException {
    	
    	String apiURL = "https://openapi.naver.com/v1/papago/n2mt";
        text = URLEncoder.encode(text, "UTF-8");
        // 언어 번역 코드 
        // String param = "source=ko&target="+lang_code+"&text=" + text;
        String param = "source=ko&target=en&text=" + text;

        try {
            URL url = new URL(apiURL);
            HttpsURLConnection con = (HttpsURLConnection) url.openConnection();
            con.setRequestProperty("X-Naver-Client-Id", clientId);
            con.setRequestProperty("X-Naver-Client-Secret", clientSecret);
            con.setRequestMethod("POST");
            con.setRequestProperty("Content-Type", "application/x-www-form-urlencoded; charset=UTF-8");
            con.setDoInput(true);
            con.setDoOutput(true);
            con.setUseCaches(false);
            con.setDefaultUseCaches(false);

            OutputStreamWriter osw = new OutputStreamWriter(con.getOutputStream());
            osw.write(param);
            osw.flush();

            int responseCode = con.getResponseCode();
            // 여기서 필요한 로직 추가...

            if (responseCode == 200) {
                // 성공적인 응답을 받았을 때만 API 응답 내용을 확인
                BufferedReader br = new BufferedReader(new InputStreamReader(con.getInputStream()));
                StringBuilder result = new StringBuilder();
                String line;

                while ((line = br.readLine()) != null) {
                    result.append(line).append("\n");
                }

                br.close();
                // 여기서 result를 반환하거나 다른 로직을 추가하여 처리
                return result.toString();
                
            } else {
                // 200코드가 아닌 경우 오류 메시지 출력
                return "Error Message: " + con.getResponseMessage() + "\n";
            }
        } catch (IOException e) {
            // IOException 처리
            return "IOException: " + e.getMessage();
        }
    }

}
