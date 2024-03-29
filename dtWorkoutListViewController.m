//
//  dtWorkoutListViewController.m
//  swell
//
//  Created by steven sickman on 11/19/13.
//  Copyright (c) 2013 steven sickman. All rights reserved.
//

#import "dtWorkoutListViewController.h"
#import "dtWorkout.h"
#import "dtWorkoutSummaryCell.h"
#import "dtWorkoutDetailViewController.h"

@interface dtWorkoutListViewController ()
@property (weak, nonatomic) IBOutlet UIBarButtonItem *settingsButton;

@property NSMutableArray *workouts;
@property dtWorkout *tappedWorkout;
@property NSMutableString *tappedTitle;
@end

@implementation dtWorkoutListViewController


- (IBAction)unwindToList:(UIStoryboardSegue *)segue
{
    
    [self.tableView reloadData];
 
}

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    //self.settingsButton = [[UIBarButtonItem alloc] init];
    self.settingsButton.title = @"\u2699";
    UIFont *f1 = [UIFont fontWithName:@"Helvetica" size:30.0];
    NSDictionary *dict = [[NSDictionary alloc] initWithObjectsAndKeys:f1, NSFontAttributeName, nil];
    [self.settingsButton setTitleTextAttributes:dict forState:UIControlStateNormal];
    
    self.workouts = [[NSMutableArray alloc] init];
    
    
    for (NSInteger i = 23; i > 0; i--) {
        dtWorkout *workout1 = [[dtWorkout alloc] init];
        workout1.session = i;
    
        [self.workouts addObject:workout1];
    }
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [self.workouts count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"WorkoutPrototypeCell";
    dtWorkoutSummaryCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    dtWorkout *workout  = [self.workouts objectAtIndex:indexPath.row];
    NSMutableString *labelText = [[NSMutableString alloc] initWithString:@"Workout "];
    [labelText appendString:[NSString stringWithFormat:@"%d", workout.session]];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"MMM d"];
    //[dateFormatter setTimeStyle:NSDateFormatterNoStyle];
    NSDate *date = [NSDate date];
    
    cell.workoutDate.font = [UIFont fontWithName:@"Helvetica" size:12];
    cell.workoutDate.text = [dateFormatter stringFromDate:date];
    
    
    cell.workoutSession.font = [UIFont fontWithName:@"Helvetica" size:12];
    cell.workoutSession.text = labelText;
    
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

    dtWorkoutSummaryCell *cell = (dtWorkoutSummaryCell *)[tableView cellForRowAtIndexPath:indexPath];

    self.tappedTitle = [NSMutableString stringWithFormat:@"%@ - %@", cell.workoutSession.text, cell.workoutDate.text];
    
   // self.tappedTitle = @"blah";
    [self performSegueWithIdentifier:@"viewWorkoutDetail" sender:self];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"viewWorkoutDetail"]) {
        dtWorkoutDetailViewController *wd = [segue destinationViewController];
        wd.segueTitle = self.tappedTitle;
    }
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a story board-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

 */

@end
