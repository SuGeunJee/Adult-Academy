package board;

import java.util.*;

public class BoardDAO {
    private static final Map<String, List<Board>> posts = new HashMap<>();
    private static final Map<String, List<Board>> qnaPosts = new HashMap<>(); // Q&A 전용 데이터

    // 일반 게시글 가져오기
    public List<Board> getPosts(String category) {
        return posts.getOrDefault(category, new ArrayList<>());
    }

    // Q&A 게시글 가져오기
    public List<Board> getQnaPosts(String category) {
        return qnaPosts.getOrDefault(category, new ArrayList<>());
    }

    // 일반 게시글 추가
    public void addPost(String category, Board post) {
        posts.computeIfAbsent(category, k -> new ArrayList<>()).add(post);
    }

    // Q&A 게시글 추가
    public void addQnaPost(String category, Board post) {
        qnaPosts.computeIfAbsent(category, k -> new ArrayList<>()).add(post);
    }

    // 일반 게시글 삭제
    public void deletePost(String category, int index) {
        List<Board> list = posts.get(category);
        if (list != null && index >= 0 && index < list.size()) {
            list.remove(index);
        }
    }

    // Q&A 게시글 삭제
    public void deleteQnaPost(String category, int index) {
        List<Board> list = qnaPosts.get(category);
        if (list != null && index >= 0 && index < list.size()) {
            list.remove(index);
        }
    }
}
