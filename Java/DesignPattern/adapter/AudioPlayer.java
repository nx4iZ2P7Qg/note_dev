package designpattern.adapter;

/**
 * 
 * @author DF
 *
 */
public class AudioPlayer implements MediaPlayer {
    MediaPlayer mediaPlayer;

    @Override
    public void play(String audioType, String fileName) {
        String mp3 = "mp3";
        String vlc = "vlc";
        String mp4 = "mp4";
        // inbuilt support to play mp3 music file
        if (audioType.equalsIgnoreCase(mp3)) {
            System.out.println("Playing mp3 file. Name: " + fileName);
        }
        // mediaAdapter is providing support to play other file formats
        else if (audioType.equalsIgnoreCase(vlc) || audioType.equalsIgnoreCase(mp4)) {
            mediaPlayer = new MediaAdapter(audioType);
            mediaPlayer.play(audioType, fileName);
        }
        //
        else {
            System.out.println("Invalid media. " + audioType + " format not supported");
        }
    }
}
