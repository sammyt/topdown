/**
 * Created by IntelliJ IDEA.
 * User: sammy
 * Date: 08/12/2010
 * Time: 19:28
 * To change this template use File | Settings | File Templates.
 */
package ziazoo.combinators
{
  public class Success implements IResult
  {
    public var result:*;
    private var input:String;
    
    public function Success(result:*, input:String)
    {
      this.result = result;
      this.input = input;
    }
  }
}
