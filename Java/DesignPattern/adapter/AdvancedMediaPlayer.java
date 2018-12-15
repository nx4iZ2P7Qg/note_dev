package designpattern.adapter;

/**
 * 
 * @author DF
 *
 */
public interface AdvancedMediaPlayer {
    /**
     * 播放vlc
     * 
     * @param fileName
     */
    void playVlc(String fileName);
    /**
     * 播放mp4
     * 
     * @param fileName
     */
    void playMp4(String fileName);
}
