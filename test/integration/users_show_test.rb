require 'test_helper'

class UsersShowTest < ActionDispatch::IntegrationTest

  def setup
    @admin = users(:god)
    @non_admin = users(:archer)
  end

  test "should not show user/<id> if user is not activated" do
    @non_admin.update_attribute(:activated, false)
    log_in_as(@admin)
    get user_path(@non_admin)
    assert_redirected_to root_url
    assert flash[:danger]
  end

  test "profile submits new title successfully (or not)" do
    log_in_as(@non_admin)
    get user_path(@non_admin)
    assert_nil @non_admin.title
    patch "/users/#{@non_admin.id}/update_description", user:
      { title: "I am a man of constant sorrow." }
    user = assigns(:user)
    user.reload.title
    assert user.title == "I am a man of constant sorrow."
    assert_redirected_to user_url(@non_admin)
    patch "/users/#{user.id}/update_description", user:
          { title: "x" * 256 }
    assert flash[:warning] # JS should disallow submission, so it doesn't
                           # get this far. Not done yet.
    descriptio = <<DESC_END
      Lorem ipsum dolor sit amet, consectetur adipiscing elit. Curabitur pulvinar vel nulla in finibus. Sed vulputate, orci pellentesque rutrum varius, augue nibh suscipit dui, non lacinia dui leo et orci. Aenean ac arcu non ante venenatis convallis. Nulla lobortis ex ut tempus accumsan. Ut sem mi, semper nec blandit vitae, blandit nec ipsum. In egestas, magna at eleifend fermentum, justo tortor cursus libero, ac convallis ipsum magna a nulla. Aliquam erat volutpat. Vestibulum sed augue dictum, tempor eros ac, consequat massa.

      Morbi id malesuada felis. Aliquam erat volutpat. Donec elementum volutpat ante at consequat. Nunc varius vehicula diam, ac fringilla turpis congue a. Mauris bibendum cursus quam sed luctus. Sed auctor semper metus quis suscipit. Proin elementum ac ipsum et lacinia. Duis tristique molestie velit ac finibus. Quisque leo nibh, interdum et arcu nec, pretium mollis urna. Suspendisse viverra, lectus eu hendrerit dignissim, est risus eleifend dolor, eu pellentesque dui est sed odio. Mauris sagittis sagittis orci sit amet condimentum.

      Suspendisse eget mauris commodo, malesuada risus a, aliquam justo. Maecenas dignissim sollicitudin tortor id cursus. Pellentesque consequat metus turpis, id fringilla felis mattis nec. Curabitur ac dui ac leo tincidunt elementum. Curabitur condimentum libero id libero tincidunt, ac viverra nulla dignissim. Sed auctor orci in finibus viverra. Sed interdum, tortor placerat ullamcorper sodales, erat nulla semper orci, sit amet interdum sapien justo at est. Quisque pulvinar risus rutrum aliquet suscipit. Suspendisse at rhoncus orci. Donec quis mauris porta, feugiat erat eu, euismod magna. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos.

      Nulla in egestas ex. Praesent pharetra odio at lobortis pharetra. Nunc nec mi eu metus eleifend pharetra. Duis sollicitudin blandit massa, ut suscipit mauris pulvinar aliquet. In id neque a eros fringilla pretium at nec neque. Phasellus aliquet pretium tellus a tincidunt. Nam a sapien et risus ornare auctor vitae id tellus. Duis sit amet tincidunt dui, id congue orci. In ornare turpis non sapien vehicula blandit. Phasellus sodales urna ut mauris pulvinar sagittis. Donec ut fringilla tellus.

      Suspendisse potenti. Vivamus mi risus, congue nec dui non, tempor elementum justo. Quisque finibus libero nec dui placerat, eu rutrum massa pretium. Fusce pulvinar lorem quis quam cursus, nec condimentum nulla lacinia. Suspendisse dictum lorem justo, vel aliquam libero euismod sit amet. Nunc ac dolor id dolor commodo tempor a ac nisi. Ut convallis, lacus a ultrices dictum, sem augue pellentesque felis, at fermentum lectus metus pharetra nulla. Vivamus nec risus sit amet nulla malesuada elementum ac et augue. Nullam cursus, mi sed tempus auctor, nisi sem faucibus leo, eu lobortis augue enim varius nibh. Donec egestas finibus justo, id accumsan nisl ultrices vel. Curabitur sed felis dapibus, facilisis augue sit amet, fermentum nunc. Morbi efficitur dictum nisl non maximus.

      Nunc tempus, quam ultricies dignissim congue, leo lacus faucibus elit, nec faucibus risus felis sit amet elit. Aenean consectetur est et dolor dignissim, vitae efficitur nisi congue. Sed pellentesque risus non urna tincidunt iaculis at ut sem. Vivamus accumsan dui sapien, eget tristique velit tempor sed. Fusce suscipit tincidunt interdum. Phasellus commodo ligula nulla, quis rhoncus mi luctus ut. Sed interdum placerat odio non pulvinar. Vestibulum nec porttitor nunc, pellentesque imperdiet est. Quisque blandit non leo non pulvinar. Nulla a dolor arcu. Aenean tristique nisi in sem iaculis, eget mattis sapien vestibulum. Suspendisse egestas, urna sed venenatis fermentum, lectus dui bibendum nibh, vel pretium velit nulla at orci. Proin feugiat nisi a sollicitudin scelerisque. Phasellus euismod accumsan nisi.

      Vivamus egestas libero diam, sed pulvinar neque rhoncus eget. Nullam commodo urna non efficitur efficitur. Suspendisse id hendrerit dolor, vel volutpat dui. Etiam ultricies elit nec turpis ultrices sodales. Quisque feugiat auctor mauris sed aliquam. Nulla ut massa viverra arcu dignissim egestas. Maecenas sollicitudin semper nunc, id vulputate lectus iaculis non. Nam in arcu elementum, malesuada elit vitae, accumsan ipsum. Vivamus id sapien accumsan arcu auctor sagittis non at lacus. Nunc bibendum ullamcorper lorem quis finibus.

      Proin at ligula quam. Vestibulum venenatis mauris non eros interdum, a euismod mauris varius. Aliquam elementum mauris in leo blandit, eu vehicula lacus blandit. Aliquam pretium nunc sed ligula aliquet porttitor. Praesent molestie, mi facilisis finibus vehicula, lectus quam cursus ante, non aliquet quam ligula eget erat. Aliquam justo justo, ullamcorper eget semper volutpat, ullamcorper a justo. Etiam faucibus est eu ullamcorper semper. Fusce ut nisl a ligula pulvinar pellentesque in ac urna. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Suspendisse sit amet augue id sapien rhoncus laoreet non vitae neque. Pellentesque id porta diam. Nunc tristique sollicitudin convallis. Etiam eu est eu ipsum fermentum dignissim in non quam. Etiam ut gravida tellus. Duis libero justo, pretium et facilisis non, mattis et tellus. Integer volutpat fringilla congue.

      Nunc nunc nisi, dignissim vel commodo id, porttitor et sapien. Nunc tincidunt velit ac libero iaculis feugiat. Vivamus pellentesque purus a imperdiet pharetra. In.
DESC_END
    patch "/users/#{@non_admin.id}/update_description", user:
      { description: descriptio }
    user = assigns(:user)
    user.reload.description
    assert user.description == descriptio
    assert_redirected_to user_url(@non_admin)
    patch "/users/#{user.id}/update_description", user:
          { description: "x" * 13_001 }
    assert flash[:warning] # JS should disallow submission, so it doesn't
                           # get this far. Not done yet.
  end

  test "profile submits new description successfully (or not)" do

  end

end
