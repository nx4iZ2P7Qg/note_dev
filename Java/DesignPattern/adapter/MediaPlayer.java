package designpattern.adapter;

/**
 * 
 * @author DF
 *
 */
public interface MediaPlayer {
    /**
     * 播放
     * 
     * @param audioType
     * @param fileName
     */
    void play(String audioType, String fileName);
}
